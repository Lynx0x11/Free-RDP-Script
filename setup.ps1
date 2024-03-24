# Disable firewall profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Download and install Chrome Remote Desktop
$ChromeRemoteDesktopInstaller = $env:TEMP + '\chromeremotedesktophost.msi'
Invoke-WebRequest 'https://dl.google.com/edgedl/chrome-remote-desktop/chromeremotedesktophost.msi' -OutFile $ChromeRemoteDesktopInstaller
Start-Process $ChromeRemoteDesktopInstaller -Wait
Remove-Item $ChromeRemoteDesktopInstaller

# Download and install Google Chrome
$ChromeInstaller = $env:TEMP + '\chrome_installer.exe'
Invoke-WebRequest 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile $ChromeInstaller
Start-Process -FilePath $ChromeInstaller -Args '/install' -Verb RunAs -Wait
Remove-Item $ChromeInstaller

# Download and install Winget
$WingetInstaller = $env:TEMP + '\winget.msixbundle'
Invoke-WebRequest 'https://aka.ms/getwinget' -OutFile $WingetInstaller
Add-AppxPackage -Path $WingetInstaller
Start-Sleep -Seconds 10  # Wait for Winget installation to finish (optional delay)
Remove-Item $WingetInstaller

# Install NirCmd using Winget
Start-Process -FilePath "winget.exe" -ArgumentList 'install', '-e', '--id', 'NirSoft.NirCmd' -Wait
