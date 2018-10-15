# repo

```
cd /d c:\clone
"C:\Program Files (x86)\Git\bin\git.exe" clone https://github.com/mikechew/repo.git
"C:\Program Files\Git\bin\git.exe" clone https://github.com/mikechew/repo.git
```

```
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -NoExit -ExecutionPolicy Unrestricted -NoProfile -File %USERPROFILE%\Desktop\inst-git.ps1
```

```
## Perform a silent install Git client

param ()

# Path for the temporary workdir
$workdir = $env:TEMP

# To avoid getting this error. 
# "Invoke-WebRequest : The request was aborted: Could not create SSL/TLS secure channel." 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download the Actifio connector software fromt the Actifio appliance
$source = "https://github.com/git-for-windows/git/releases/download/v2.19.1.windows.1/Git-2.19.1-32-bit.exe"
$destination = "$workdir\git.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient
if (Get-Command 'Invoke-Webrequest') {
     Invoke-WebRequest $source -OutFile $destination
} else {
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}

# Kick off the installation of the Actifio connector
Start-Process -FilePath $destination 
# Start-Process -Wait $env:TEMP\git.exe -ArgumentList /silent

# Wait XX Seconds for the installation to finish
Start-Sleep -s 35

# Remove the installer directory
Remove-Item $destination -Force
```
