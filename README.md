# Edura Browser

A secure, kiosk-ready browser application built on the Chromium Embedded Framework (CEF). Designed for controlled browsing environments with enhanced security features and professional branding.

![Edura Browser](new%20icons/edura.png)

## 🎯 Features

### 🔒 Security Features
- **No external navigation** - Users cannot click links to navigate away from intended content
- **No text selection** - Prevents copying of sensitive information
- **No context menu customization** - Minimal right-click options
- **No popup windows** - All popups are blocked
- **No developer tools** - No access to debugging or inspection tools
- **No zoom functionality** - Zoom via keyboard, mouse wheel, and touch gestures is completely disabled
- **Fullscreen support** - Optional fullscreen mode via `--fullscreen` flag

### 🖥️ Kiosk Mode Ready
- **Windows Kiosk Mode compatible** - Works seamlessly with Windows Assigned Access
- **URL parameter support** - `cefsimple.exe --url=https://your-site.com`
- **Clean interface** - No toolbars, menus, or customization options
- **Professional branding** - Custom Edura icons and window titles

### ⚙️ Flexible Deployment
- **Address bar navigation** - Users can type URLs directly (in cefclient)
- **Search functionality** - Google search and other search engines work normally
- **Form inputs** - Text fields and search boxes are fully functional
- **Redirects supported** - Automatic redirects work properly

## 📦 Applications

### cefsimple - Secure Kiosk Browser
- **Location**: `build/tests/cefsimple/Release/cefsimple.exe`
- **Purpose**: Production kiosk deployment
- **Features**: Maximum security, minimal interface
- **Usage**: `cefsimple.exe --url=https://your-site.com`
- 
## 🚀 Quick Start

### Prerequisites
- Windows 10/11
- Visual Studio 2019/2022 with C++ support
- CMake 3.19 or later

### Building from Source

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mooo0042/edura.git
   cd edura
   ```

2. **Extract CEF Binary**
   - Download CEF binary distribution
   - Extract to project root
   - Ensure folder structure matches the build paths

3. **Build the project**
   ```bash
   cd cef_binary_139.0.28+g55ab8a8+chromium-139.0.7258.139_windows64
   mkdir build
   cd build
   cmake ..
   cmake --build . --config Release --target cefsimple
   ```

4. **Run the application**
   ```bash
   .\tests\cefsimple\Release\cefsimple.exe
   ```

## 📋 Installation

### Using the Installer
1. Download `EduraBrowserSetup.exe` from releases
2. Run the installer as administrator
3. Follow the installation wizard
4. Launch from Start Menu or Desktop shortcut

### Manual Installation
1. Copy all files from `build/tests/cefsimple/Release/` to your desired location
2. Ensure all DLLs and data files are in the same directory as `cefsimple.exe`
3. Run `cefsimple.exe` from the installation directory

## 🔧 Configuration

### Kiosk Mode Setup
1. **Windows Settings** → **Accounts** → **Family & other users**
2. **Set up a kiosk** → **Assigned access**
3. **Choose an app** → Browse to `cefsimple.exe`
4. **Configure URL** (optional): Add `--url=https://your-site.com` to app arguments

### URL Configuration
```bash
# Open specific website
cefsimple.exe --url=https://your-company-portal.com

# Open local HTML file
cefsimple.exe --url=file:///C:/kiosk/content/index.html

# Launch in fullscreen mode
cefsimple.exe --fullscreen --url=https://your-site.com

# Combine multiple options
cefsimple.exe --fullscreen --url=https://your-company-portal.com

# Default (opens Google)
cefsimple.exe
```

## 🛠️ Development

### Project Structure
```
edura/
├── cef_binary_139.0.28+g55ab8a8+chromium-139.0.7258.139_windows64/
│   ├── tests/cefsimple/          # Secure kiosk browser source
│   ├── tests/cefclient/          # Development browser source
│   ├── new icons/                # Edura branding assets
│   ├── build/                    # Build output directory
│   └── EduraBrowserSetup.iss     # Inno Setup installer script
├── README.md
└── LICENSE
```

### Key Modifications
- **Security restrictions** in `base_client_handler.cc` and `simple_handler.cc`
- **Branding updates** in resource files and window titles
- **Icon replacements** throughout the project
- **Navigation controls** to prevent unwanted browsing

## 📄 License

Copyright (C) 2025 Mod-Sauce. All rights reserved.

This project includes components from the Chromium Embedded Framework (CEF), which is subject to its own license terms.

See [EDURA_LICENSE.txt](EDURA_LICENSE.txt) for full license text.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📞 Support

For support or questions:
- Create an issue on GitHub
- Contact your system administrator

## 🏷️ Version History

### v1.0.0 (2025-01-25)
- Initial release
- Secure kiosk browser implementation
- Professional Edura branding
- Windows installer package
- Full CEF 139.0.28 integration

---
* Support Forum - http://www.magpcss.org/ceforum/
* Issue Tracker - https://github.com/chromiumembedded/cef/issues
* C++ API Docs - [Stable release docs](https://cef-builds.spotifycdn.com/docs/stable.html) / [Beta release docs](https://cef-builds.spotifycdn.com/docs/beta.html)
* Downloads - https://cef-builds.spotifycdn.com/index.html
* Donations - http://www.magpcss.org/ceforum/donate.php

# Introduction

CEF is a BSD-licensed open source project founded by Marshall Greenblatt in 2008 and based on the [Google Chromium](http://www.chromium.org/Home) project. Unlike the Chromium project itself, which focuses mainly on Google Chrome application development, CEF focuses on facilitating embedded browser use cases in third-party applications. CEF insulates the user from the underlying Chromium and Blink code complexity by offering production-quality stable APIs, release branches tracking specific Chromium releases, and binary distributions. Most features in CEF have default implementations that provide rich functionality while requiring little or no integration work from the user. There are currently over 100 million installed instances of CEF around the world embedded in products from a wide range of companies and industries. A partial list of companies and products using CEF is available on the [CEF Wikipedia page](http://en.wikipedia.org/wiki/Chromium_Embedded_Framework#Applications_using_CEF). Some use cases for CEF include:

* Embedding an HTML5-compliant Web browser control in an existing native application.
* Creating a light-weight native “shell” application that hosts a user interface developed primarily using Web technologies.
* Rendering Web content “off-screen” in applications that have their own custom drawing frameworks.
* Acting as a host for automated testing of existing Web properties and applications.

CEF supports a wide range of programming languages and operating systems and can be easily integrated into both new and existing applications. It was designed from the ground up with both performance and ease of use in mind. The base framework includes C and C++ programming interfaces exposed via native libraries that insulate the host application from Chromium and Blink implementation details. It provides close integration between the browser and the host application including support for custom plugins, protocols, JavaScript objects and JavaScript extensions. The host application can optionally control resource loading, navigation, context menus, printing and more, while taking advantage of the same performance and HTML5 technologies available in the Google Chrome Web browser.

Numerous individuals and organizations contribute time and resources to support CEF development, but more involvement from the community is always welcome. This includes support for both the core CEF project and external projects that integrate CEF with additional programming languages and frameworks (see the "External Projects" section below). If you are interested in donating time to help with CEF development please see the "Helping Out" section below. If you are interested in donating money to support general CEF development and infrastructure efforts please visit the [CEF Donations](http://www.magpcss.org/ceforum/donate.php) page.

# Getting Started

Users new to CEF development should start by reading the [Tutorial](https://bitbucket.org/chromiumembedded/cef/wiki/Tutorial) Wiki page for an overview of CEF usage and then proceed to the [GeneralUsage](https://bitbucket.org/chromiumembedded/cef/wiki/GeneralUsage) Wiki page for a more in-depth discussion or architectural and usage issues. Complete API documentation is available [here](https://cef-builds.spotifycdn.com/docs/stable.html). CEF support and related discussion is available on the [CEF Forum](http://www.magpcss.org/ceforum/).

# Binary Distributions

Binary distributions, which include all files necessary to build a CEF-based application, are available on the [Downloads](https://cef-builds.spotifycdn.com/index.html) page. Binary distributions are stand-alone and do not require the download of CEF or Chromium source code. Symbol files for debugging binary distributions of libcef can also be downloaded from the above links.

# Source Distributions

The CEF project is an extension of the Chromium project. CEF maintains development and release branches that track Chromium branches. CEF source code can be downloaded, built and packaged manually or with automated tools. Visit the [BranchesAndBuilding](https://bitbucket.org/chromiumembedded/cef/wiki/BranchesAndBuilding) Wiki page for more information.

# External Projects

The base CEF framework includes support for the C and C++ programming languages. Thanks to the hard work of external maintainers CEF can integrate with a number of other programming languages and frameworks. These external projects are not maintained by CEF so please contact the respective project maintainer if you have any questions or issues.

* .Net (CEF3) - https://github.com/cefsharp/CefSharp
* .Net (CEF1) - https://bitbucket.org/fddima/cefglue
* .Net/Mono (CEF3) - https://gitlab.com/xiliumhq/chromiumembedded/cefglue
* Delphi - https://github.com/hgourvest/dcef3
* Delphi - https://github.com/salvadordf/CEF4Delphi
* Go - https://github.com/CzarekTomczak/cef2go
* Go - https://github.com/energye/energy
* Java - https://bitbucket.org/chromiumembedded/java-cef
* Python - http://code.google.com/p/cefpython/

If you're the maintainer of a project not listed above and would like your project listed here please either post to the [CEF Forum](http://www.magpcss.org/ceforum/) or contact Marshall directly.

# Helping Out

CEF is still very much a work in progress. Some ways that you can help out:

\- Vote for issues in the [CEF issue tracker](https://github.com/chromiumembedded/cef/issues) that are important to you. This helps with development prioritization.

\- Report any bugs that you find or feature requests that are important to you. Make sure to first search for existing issues before creating new ones. Please use the [CEF Forum](http://magpcss.org/ceforum) and not the issue tracker for usage questions. Each CEF issue should:

* Include the CEF revision or binary distribution version.
* Include information about your OS and compiler version.
* If the issue is a bug please provide detailed reproduction information.
* If the issue is a feature please describe why the feature is beneficial.

\- Write unit tests for new or existing functionality.

\- Pull requests and patches are welcome. View open issues in the [CEF issue tracker](https://github.com/chromiumembedded/cef/issues) or search for TODO(cef) in the source code for ideas.

If you would like to contribute source code changes to CEF please follow the below guidelines:

\- Create or find an appropriate issue for each distinct bug, feature or change. 

\- Submit a [pull request](https://bitbucket.org/chromiumembedded/cef/wiki/ContributingWithGit) or create a patch with your changes and attach it to the CEF issue. Changes should:

* Be submitted against the current [CEF master branch](https://bitbucket.org/chromiumembedded/cef/src/?at=master) unless explicitly fixing a bug in a CEF release branch.
* Follow the style of existing CEF source files. In general CEF uses the [Chromium C++ style guide](https://chromium.googlesource.com/chromium/src/+/master/styleguide/c++/c++.md).
* Include new or modified unit tests as appropriate to the functionality.
* Not include unnecessary or unrelated changes.
