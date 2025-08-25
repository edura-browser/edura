; Edura Browser Installer Script
; NSIS Modern User Interface

!include "MUI2.nsh"

; General
Name "Edura Browser"
OutFile "EduraBrowserSetup.exe"
Unicode True

; Default installation folder
InstallDir "$PROGRAMFILES\Edura Browser"

; Get installation folder from registry if available
InstallDirRegKey HKCU "Software\Edura Browser" ""

; Request application privileges for Windows Vista/7/8/10/11
RequestExecutionLevel admin

; Variables
Var StartMenuFolder

; Interface Settings
!define MUI_ABORTWARNING

; Pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
!insertmacro MUI_PAGE_DIRECTORY

; Start Menu Folder Page Configuration
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\Edura Browser" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

!insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Languages
!insertmacro MUI_LANGUAGE "English"

; Installer Sections
Section "Edura Browser" SecMain

  SetOutPath "$INSTDIR"
  
  ; Main executable
  File "build\tests\cefsimple\Release\cefsimple.exe"
  
  ; CEF Runtime files
  File "build\tests\cefsimple\Release\libcef.dll"
  File "build\tests\cefsimple\Release\chrome_elf.dll"
  File "build\tests\cefsimple\Release\d3dcompiler_47.dll"
  File "build\tests\cefsimple\Release\dxcompiler.dll"
  File "build\tests\cefsimple\Release\dxil.dll"
  File "build\tests\cefsimple\Release\libEGL.dll"
  File "build\tests\cefsimple\Release\libGLESv2.dll"
  File "build\tests\cefsimple\Release\vk_swiftshader.dll"
  File "build\tests\cefsimple\Release\vulkan-1.dll"
  
  ; CEF Data files
  File "build\tests\cefsimple\Release\chrome_100_percent.pak"
  File "build\tests\cefsimple\Release\chrome_200_percent.pak"
  File "build\tests\cefsimple\Release\resources.pak"
  File "build\tests\cefsimple\Release\icudtl.dat"
  File "build\tests\cefsimple\Release\v8_context_snapshot.bin"
  File "build\tests\cefsimple\Release\vk_swiftshader_icd.json"
  
  ; Locales folder
  SetOutPath "$INSTDIR\locales"
  File "build\tests\cefsimple\Release\locales\*.pak"
  
  ; Store installation folder
  WriteRegStr HKCU "Software\Edura Browser" "" $INSTDIR
  
  ; Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  ; Add to Add/Remove Programs
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                   "DisplayName" "Edura Browser"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                   "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                   "DisplayIcon" "$INSTDIR\cefsimple.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                   "Publisher" "Edura"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                   "DisplayVersion" "1.0"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                     "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser" \
                     "NoRepair" 1

SectionEnd

; Start Menu Shortcuts
Section "Start Menu Shortcuts" SecStartMenu

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\Edura Browser.lnk" "$INSTDIR\cefsimple.exe"
    CreateShortcut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

; Desktop Shortcut (Optional)
Section /o "Desktop Shortcut" SecDesktop

  CreateShortcut "$DESKTOP\Edura Browser.lnk" "$INSTDIR\cefsimple.exe"

SectionEnd

; Descriptions
LangString DESC_SecMain ${LANG_ENGLISH} "Edura Browser application and required files."
LangString DESC_SecStartMenu ${LANG_ENGLISH} "Start Menu shortcuts for Edura Browser."
LangString DESC_SecDesktop ${LANG_ENGLISH} "Desktop shortcut for Edura Browser."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecMain} $(DESC_SecMain)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecStartMenu} $(DESC_SecStartMenu)
  !insertmacro MUI_DESCRIPTION_TEXT ${SecDesktop} $(DESC_SecDesktop)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; Uninstaller Section
Section "Uninstall"

  ; Remove files
  Delete "$INSTDIR\cefsimple.exe"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.pak"
  Delete "$INSTDIR\*.dat"
  Delete "$INSTDIR\*.bin"
  Delete "$INSTDIR\*.json"
  Delete "$INSTDIR\locales\*.pak"
  RMDir "$INSTDIR\locales"
  Delete "$INSTDIR\Uninstall.exe"
  RMDir "$INSTDIR"

  ; Remove shortcuts
  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder
  Delete "$SMPROGRAMS\$StartMenuFolder\Edura Browser.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"
  Delete "$DESKTOP\Edura Browser.lnk"

  ; Remove registry keys
  DeleteRegKey HKCU "Software\Edura Browser"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\EduraBrowser"

SectionEnd
