[Setup]
AppName=Catalyst Launcher
AppPublisher=Catalyst
UninstallDisplayName=Catalyst
AppVersion=${project.version}
AppSupportURL=https://catalyst.net/
DefaultDirName={localappdata}\Catalyst

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/innosetup/app_small.bmp
WizardImageFile=${basedir}/innosetup/left.bmp
SetupIconFile=${basedir}/innosetup/app.ico
UninstallDisplayIcon={app}\Catalyst.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=OpenRuneSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\build\win-aarch64\Catalyst.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-aarch64\Catalyst.jar"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${basedir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Catalyst\Catalyst"; Filename: "{app}\Catalyst.exe"
Name: "{userprograms}\Catalyst\Catalyst (configure)"; Filename: "{app}\Catalyst.exe"; Parameters: "--configure"
Name: "{userprograms}\Catalyst\Catalyst (safe mode)"; Filename: "{app}\Catalyst.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Catalyst"; Filename: "{app}\Catalyst.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Catalyst.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Catalyst.exe"; Description: "&Open Catalyst"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Catalyst.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Catalyst\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"