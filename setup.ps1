# Disable firewall profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Define URLs for Chrome Remote Desktop and other installers
$ChromeRemoteDesktopURL = 'https://github.com/d4rkd3v1l1702/Free-RDP-Script/raw/main/chromeremotedesktophost.msi'
$ChromeInstallerURL = 'https://dl.google.com/chrome/install/latest/chrome_installer.exe'
$WingetInstallerURL = 'https://aka.ms/getwinget'

# Download and install Chrome Remote Desktop
$ChromeRemoteDesktopInstaller = $env:TEMP + '\chromeremotedesktophost.msi'
Invoke-WebRequest -Uri $ChromeRemoteDesktopURL -OutFile $ChromeRemoteDesktopInstaller
Start-Process $ChromeRemoteDesktopInstaller -Wait
Remove-Item $ChromeRemoteDesktopInstaller

# Download and install Google Chrome
$ChromeInstaller = $env:TEMP + '\chrome_installer.exe'
Invoke-WebRequest -Uri $ChromeInstallerURL -OutFile $ChromeInstaller
Start-Process -FilePath $ChromeInstaller -Args '/install' -Verb RunAs -Wait
Remove-Item $ChromeInstaller

# Download and install Winget
$WingetInstaller = $env:TEMP + '\winget.msixbundle'
Invoke-WebRequest -Uri $WingetInstallerURL -OutFile $WingetInstaller
Add-AppxPackage -Path $WingetInstaller
Start-Sleep -Seconds 10  # Wait for Winget installation to finish (optional delay)
Remove-Item $WingetInstaller

# Install NirCmd using Winget
Start-Process -FilePath "winget" -ArgumentList 'install', '-e', '--id', 'NirSoft.NirCmd' -Wait
