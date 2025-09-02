// Copyright (c) 2013 The Chromium Embedded Framework Authors. All rights
// reserved. Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

#include "tests/cefsimple/simple_handler.h"

#include <sstream>
#include <string>

#include "include/base/cef_callback.h"
#include "include/cef_app.h"
#include "include/cef_parser.h"
#include "include/views/cef_browser_view.h"
#include "include/views/cef_window.h"
#include "include/wrapper/cef_closure_task.h"
#include "include/wrapper/cef_helpers.h"

namespace {

SimpleHandler* g_instance = nullptr;

// Returns a data: URI with the specified contents.
std::string GetDataURI(const std::string& data, const std::string& mime_type) {
  return "data:" + mime_type + ";base64," +
         CefURIEncode(CefBase64Encode(data.data(), data.size()), false)
             .ToString();
}

}  // namespace

SimpleHandler::SimpleHandler(bool is_alloy_style)
    : is_alloy_style_(is_alloy_style) {
  DCHECK(!g_instance);
  g_instance = this;
}

SimpleHandler::~SimpleHandler() {
  g_instance = nullptr;
}

// static
SimpleHandler* SimpleHandler::GetInstance() {
  return g_instance;
}

void SimpleHandler::OnTitleChange(CefRefPtr<CefBrowser> browser,
                                  const CefString& title) {
  CEF_REQUIRE_UI_THREAD();

  // Always show "Edura" as the window title instead of the page title
  const CefString edura_title = "Edura";

  if (auto browser_view = CefBrowserView::GetForBrowser(browser)) {
    // Set the title of the window using the Views framework.
    CefRefPtr<CefWindow> window = browser_view->GetWindow();
    if (window) {
      window->SetTitle(edura_title);
    }
  } else if (is_alloy_style_) {
    // Set the title of the window using platform APIs.
    PlatformTitleChange(browser, edura_title);
  }
}

void SimpleHandler::OnAfterCreated(CefRefPtr<CefBrowser> browser) {
  CEF_REQUIRE_UI_THREAD();

  // Sanity-check the configured runtime style.
  CHECK_EQ(is_alloy_style_ ? CEF_RUNTIME_STYLE_ALLOY : CEF_RUNTIME_STYLE_CHROME,
           browser->GetHost()->GetRuntimeStyle());

  // Add to the list of existing browsers.
  browser_list_.push_back(browser);
}

bool SimpleHandler::DoClose(CefRefPtr<CefBrowser> browser) {
  CEF_REQUIRE_UI_THREAD();

  // Closing the main window requires special handling. See the DoClose()
  // documentation in the CEF header for a detailed destription of this
  // process.
  if (browser_list_.size() == 1) {
    // Set a flag to indicate that the window close should be allowed.
    is_closing_ = true;
  }

  // Allow the close. For windowed browsers this will result in the OS close
  // event being sent.
  return false;
}

void SimpleHandler::OnBeforeClose(CefRefPtr<CefBrowser> browser) {
  CEF_REQUIRE_UI_THREAD();

  // Remove from the list of existing browsers.
  BrowserList::iterator bit = browser_list_.begin();
  for (; bit != browser_list_.end(); ++bit) {
    if ((*bit)->IsSame(browser)) {
      browser_list_.erase(bit);
      break;
    }
  }

  if (browser_list_.empty()) {
    // All browser windows have closed. Quit the application message loop.
    CefQuitMessageLoop();
  }
}

void SimpleHandler::OnLoadError(CefRefPtr<CefBrowser> browser,
                                CefRefPtr<CefFrame> frame,
                                ErrorCode errorCode,
                                const CefString& errorText,
                                const CefString& failedUrl) {
  CEF_REQUIRE_UI_THREAD();

  // Allow Chrome to show the error page.
  if (!is_alloy_style_) {
    return;
  }

  // Don't display an error for downloaded files.
  if (errorCode == ERR_ABORTED) {
    return;
  }

  // Display a load error message using a data: URI.
  std::stringstream ss;
  ss << "<html><body bgcolor=\"white\">"
        "<h2>Failed to load URL "
     << std::string(failedUrl) << " with error " << std::string(errorText)
     << " (" << errorCode << ").</h2></body></html>";

  frame->LoadURL(GetDataURI(ss.str(), "text/html"));
}

void SimpleHandler::ShowMainWindow() {
  if (!CefCurrentlyOn(TID_UI)) {
    // Execute on the UI thread.
    CefPostTask(TID_UI, base::BindOnce(&SimpleHandler::ShowMainWindow, this));
    return;
  }

  if (browser_list_.empty()) {
    return;
  }

  auto main_browser = browser_list_.front();

  if (auto browser_view = CefBrowserView::GetForBrowser(main_browser)) {
    // Show the window using the Views framework.
    if (auto window = browser_view->GetWindow()) {
      window->Show();
    }
  } else if (is_alloy_style_) {
    PlatformShowWindow(main_browser);
  }
}

void SimpleHandler::CloseAllBrowsers(bool force_close) {
  if (!CefCurrentlyOn(TID_UI)) {
    // Execute on the UI thread.
    CefPostTask(TID_UI, base::BindOnce(&SimpleHandler::CloseAllBrowsers, this,
                                       force_close));
    return;
  }

  if (browser_list_.empty()) {
    return;
  }

  BrowserList::const_iterator it = browser_list_.begin();
  for (; it != browser_list_.end(); ++it) {
    (*it)->GetHost()->CloseBrowser(force_close);
  }
}

void SimpleHandler::OnLoadEnd(CefRefPtr<CefBrowser> browser,
                              CefRefPtr<CefFrame> frame,
                              int httpStatusCode) {
  CEF_REQUIRE_UI_THREAD();

  // Inject CSS and JavaScript to disable text selection, pointer events, and zoom
  std::string security_code =
    "var style = document.createElement('style');"
    "style.type = 'text/css';"
    "style.innerHTML = '"
    "* { "
    "  -webkit-user-select: none !important; "
    "  -moz-user-select: none !important; "
    "  -ms-user-select: none !important; "
    "  user-select: none !important; "
    "} "
    "a, button, input[type=\"button\"], input[type=\"submit\"], input[type=\"reset\"] { "
    "  pointer-events: none !important; "
    "  cursor: default !important; "
    "} "
    "input[type=\"text\"], input[type=\"search\"], textarea { "
    "  pointer-events: auto !important; "
    "  -webkit-user-select: text !important; "
    "  -moz-user-select: text !important; "
    "  -ms-user-select: text !important; "
    "  user-select: text !important; "
    "} "
    "';"
    "document.head.appendChild(style);"

    // Disable zoom via mouse wheel and keyboard
    "document.addEventListener('wheel', function(e) {"
    "  if (e.ctrlKey) { e.preventDefault(); }"
    "}, { passive: false });"

    "document.addEventListener('keydown', function(e) {"
    "  if (e.ctrlKey && (e.key === '+' || e.key === '-' || e.key === '0')) {"
    "    e.preventDefault();"
    "  }"
    "});"

    // Disable touch zoom gestures
    "document.addEventListener('touchstart', function(e) {"
    "  if (e.touches.length > 1) { e.preventDefault(); }"
    "}, { passive: false });"

    "document.addEventListener('touchmove', function(e) {"
    "  if (e.touches.length > 1) { e.preventDefault(); }"
    "}, { passive: false });";

  frame->ExecuteJavaScript(security_code, frame->GetURL(), 0);
}

bool SimpleHandler::OnBeforeBrowse(CefRefPtr<CefBrowser> browser,
                                   CefRefPtr<CefFrame> frame,
                                   CefRefPtr<CefRequest> request,
                                   bool user_gesture,
                                   bool is_redirect) {
  CEF_REQUIRE_UI_THREAD();

  // Allow all navigation for now - we'll handle link blocking via CSS
  // This ensures initial page loads and address bar navigation work
  return false;
}

bool SimpleHandler::OnOpenURLFromTab(
    CefRefPtr<CefBrowser> browser,
    CefRefPtr<CefFrame> frame,
    const CefString& target_url,
    CefRequestHandler::WindowOpenDisposition target_disposition,
    bool user_gesture) {
  // Block opening URLs in new tabs/windows
  // Force navigation in the same tab instead
  if (target_disposition != CEF_WOD_CURRENT_TAB) {
    // Navigate in current tab instead of opening new tab/window
    browser->GetMainFrame()->LoadURL(target_url);
    return true; // Block the original new tab/window request
  }
  return false; // Allow navigation in current tab
}

bool SimpleHandler::OnBeforePopup(
    CefRefPtr<CefBrowser> browser,
    CefRefPtr<CefFrame> frame,
    int popup_id,
    const CefString& target_url,
    const CefString& target_frame_name,
    CefLifeSpanHandler::WindowOpenDisposition target_disposition,
    bool user_gesture,
    const CefPopupFeatures& popupFeatures,
    CefWindowInfo& windowInfo,
    CefRefPtr<CefClient>& client,
    CefBrowserSettings& settings,
    CefRefPtr<CefDictionaryValue>& extra_info,
    bool* no_javascript_access) {
  CEF_REQUIRE_UI_THREAD();

  // Block all popup creation to prevent navigation to external sites
  return true;
}

void SimpleHandler::OnBeforeContextMenu(CefRefPtr<CefBrowser> browser,
                                        CefRefPtr<CefFrame> frame,
                                        CefRefPtr<CefContextMenuParams> params,
                                        CefRefPtr<CefMenuModel> model) {
  CEF_REQUIRE_UI_THREAD();

  // Clear all context menu items to remove customization options
  model->Clear();
}

bool SimpleHandler::OnPreKeyEvent(CefRefPtr<CefBrowser> browser,
                                  const CefKeyEvent& event,
                                  CefEventHandle os_event,
                                  bool* is_keyboard_shortcut) {
  CEF_REQUIRE_UI_THREAD();

  // Block zoom keyboard shortcuts
  if (event.type == KEYEVENT_KEYDOWN || event.type == KEYEVENT_RAWKEYDOWN) {
    // Check for Ctrl key combinations
    if (event.modifiers & EVENTFLAG_CONTROL_DOWN) {
      // Block Ctrl+Plus (zoom in)
      if (event.windows_key_code == VK_OEM_PLUS || event.windows_key_code == VK_ADD) {
        return true; // Block the event
      }
      // Block Ctrl+Minus (zoom out)
      if (event.windows_key_code == VK_OEM_MINUS || event.windows_key_code == VK_SUBTRACT) {
        return true; // Block the event
      }
      // Block Ctrl+0 (reset zoom)
      if (event.windows_key_code == '0' || event.windows_key_code == VK_NUMPAD0) {
        return true; // Block the event
      }
      // Block F11 (fullscreen toggle) - only if not explicitly enabled
      if (event.windows_key_code == VK_F11) {
        // Check if fullscreen flag is enabled
        CefRefPtr<CefCommandLine> command_line = CefCommandLine::GetGlobalCommandLine();
        if (!command_line->HasSwitch("fullscreen")) {
          return true; // Block F11 if fullscreen not enabled
        }
      }
    }
  }

  return false; // Allow other key events
}

bool SimpleHandler::OnKeyEvent(CefRefPtr<CefBrowser> browser,
                               const CefKeyEvent& event,
                               CefEventHandle os_event) {
  CEF_REQUIRE_UI_THREAD();

  // Additional key event handling if needed
  // This is called after the renderer has processed the event
  return false; // Don't handle any key events here
}

#if !defined(OS_MAC)
void SimpleHandler::PlatformShowWindow(CefRefPtr<CefBrowser> browser) {
  NOTIMPLEMENTED();
}
#endif
