[Setup]
; Basic Information
AppName=Edura Browser
AppVersion=1.0
AppPublisher=Mod-Sauce
DefaultDirName={autopf}\Edura Browser
DefaultGroupName=Edura Browser
AllowNoIcons=yes
LicenseFile=EDURA_LICENSE.txt
OutputDir=installer
OutputBaseFilename=EduraBrowserSetup
SetupIconFile=new icons\edura.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin

; Version Information
VersionInfoVersion=1.0.0.0
VersionInfoCompany=Mod-Sauce
VersionInfoDescription=Edura Browser Installer
VersionInfoCopyright=Copyright (C) 2025 Mod-Sauce

; Prerequisites
MinVersion=6.1sp1

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 6.1

[Files]
; Install ALL files from the Release directory to ensure nothing is missing
Source: "build\tests\cefsimple\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.lib,*.exp,debug.log"

; Documentation
Source: "EDURA_LICENSE.txt"; DestDir: "{app}"; DestName: "LICENSE.txt"; Flags: ignoreversion
Source: "LICENSE.txt"; DestDir: "{app}"; DestName: "CEF_LICENSE.txt"; Flags: ignoreversion

; Icon file for potential resource editing
Source: "new icons\edura.ico"; DestDir: "{app}"; DestName: "edura.ico"; Flags: ignoreversion

[Icons]
Name: "{group}\Edura Browser"; Filename: "{app}\cefsimple.exe"; WorkingDir: "{app}"; IconFilename: "{app}\edura.ico"
Name: "{group}\{cm:UninstallProgram,Edura Browser}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\Edura Browser"; Filename: "{app}\cefsimple.exe"; WorkingDir: "{app}"; Tasks: desktopicon; IconFilename: "{app}\edura.ico"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\Edura Browser"; Filename: "{app}\cefsimple.exe"; WorkingDir: "{app}"; Tasks: quicklaunchicon; IconFilename: "{app}\edura.ico"

[Run]
Filename: "{app}\cefsimple.exe"; WorkingDir: "{app}"; Description: "{cm:LaunchProgram,Edura Browser}"; Flags: nowait postinstall skipifsilent

[Registry]
; Register application for kiosk mode
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\cefsimple.exe"; ValueType: string; ValueName: ""; ValueData: "{app}\cefsimple.exe"
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\cefsimple.exe"; ValueType: string; ValueName: "Path"; ValueData: "{app}"

; Add to Windows Kiosk app list
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\AssignedAccessConfiguration\KioskModeApp"; ValueType: string; ValueName: "EduraBrowser"; ValueData: "{app}\cefsimple.exe"

[UninstallDelete]
Type: filesandordirs; Name: "{app}\locales"
Type: files; Name: "{app}\debug.log"

[Code]
function GetUninstallString(): String;
var
  sUnInstPath: String;
  sUnInstallString: String;
begin
  sUnInstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUnInstallString := '';
  if not RegQueryStringValue(HKLM, sUnInstPath, 'UninstallString', sUnInstallString) then
    RegQueryStringValue(HKCU, sUnInstPath, 'UninstallString', sUnInstallString);
  Result := sUnInstallString;
end;

function IsUpgrade(): Boolean;
begin
  Result := (GetUninstallString() <> '');
end;

function UnInstallOldVersion(): Integer;
var
  sUnInstallString: String;
  iResultCode: Integer;
begin
  Result := 0;
  sUnInstallString := GetUninstallString();
  if sUnInstallString <> '' then begin
    sUnInstallString := RemoveQuotes(sUnInstallString);
    if Exec(sUnInstallString, '/SILENT /NORESTART /SUPPRESSMSGBOXES','', SW_HIDE, ewWaitUntilTerminated, iResultCode) then
      Result := 3
    else
      Result := 2;
  end else
    Result := 1;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep=ssInstall) then
  begin
    if (IsUpgrade()) then
    begin
      UnInstallOldVersion();
    end;
  end;
end;
