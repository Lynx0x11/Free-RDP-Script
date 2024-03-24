# Disable firewall profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Download and install Chrome Remote Desktop
$P = $env:TEMP + '\chromeremotedesktophost.msi'
Invoke-WebRequest 'https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi' -OutFile $P
Start-Process $P -Wait
Remove-Item $P

# Download and install Google Chrome
$P = $env:TEMP + '\chrome_installer.exe'
Invoke-WebRequest 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile $P
Start-Process -FilePath $P -Args '/install' -Verb RunAs -Wait
Remove-Item $P

# Download Winget MSI installer
$WingetInstaller = $env:TEMP + '\winget.msi'
Invoke-WebRequest 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle' -OutFile $WingetInstaller

# Install Winget using msiexec
Start-Process msiexec.exe -ArgumentList "/i $WingetInstaller /quiet" -Wait
Remove-Item $WingetInstaller

# Install NirCmd using Winget
Start-Process -FilePath "winget" -ArgumentList 'install', '-e', '--id', 'NirSoft.NirCmd' -Wait
