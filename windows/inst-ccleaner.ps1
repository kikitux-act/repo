# Silent Install CCleaner
# http://www.piriform.com/ccleaner/download

# Path for the workdir
$workdir = "c:\installer\"

# Check if work directory exists if not create it

If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }

# Download the installer

$source = "http://download.piriform.com/ccsetup535.exe"
$destination = "$workdir\ccsetup.exe"

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}


# Start the installation
Start-Process -FilePath "$workdir\ccsetup.exe" -ArgumentList "/S"

# Wait XX Seconds for the installation to finish
Start-Sleep -s 35

# Remove the installer
rm -Force $workdir\c*

## For Windows 7 please change 

## $source = "http://download.piriform.com/ccsetup526.exe"
## $destination = "$workdir\ccsetup.exe"
## Invoke-WebRequest $source -OutFile $destination
## To

## $WebClient = New-Object System.Net.WebClient
## $WebClient.DownloadFile("http://download.piriform.com/ccsetup526.exe","C:\installer\ccsetup.exe")
## Since Powershell in Windows 7 does not support the Invoke-WebRequest
