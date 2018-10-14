$Path = $env:TEMP
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait; 
Remove-Item $Path\$Installer


## Install Google Chrome on Windows Server with a Powershell Script
# $LocalTempDir = "c:\installer\"
# $ChromeInstaller = "ChromeInstaller.exe"; 
# (new-object System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; 
# $Process2Monitor =  "ChromeInstaller"; 
# Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; 
# If ($ProcessesFound) 
# { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } 
# else 
# { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } 
# Until (!$ProcessesFound)
