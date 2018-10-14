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

$FileExist = $True
If ((Test-Path $destination) -eq $False) {
    $FileExist = $False
} 

# Check if Invoke-Webrequest exists otherwise execute WebClient

if (Get-Command 'Invoke-Webrequest')
{
     if ($FileExist -eq $False) {
        Invoke-WebRequest $source -OutFile $destination
     }
}
else
{
    if ($FileExist -eq $False) {
      $WebClient = New-Object System.Net.WebClient
      $webclient.DownloadFile($source, $destination)
    }
}

# $SourceFile = "\\server\software\ccsetup.exe"
# Copy-Item -Path $SourceFile -Destination $Destination -Force

# Start the installation
Start-Process -FilePath "$workdir\ccsetup.exe" -ArgumentList "/S"

# Wait XX Seconds for the installation to finish
Start-Sleep -s 35

# Remove the installer
rm -Force $destination

## For Windows 7 please change 

## $source = "http://download.piriform.com/ccsetup526.exe"
## $destination = "$workdir\ccsetup.exe"
## Invoke-WebRequest $source -OutFile $destination
## To

## $WebClient = New-Object System.Net.WebClient
## $WebClient.DownloadFile("http://download.piriform.com/ccsetup526.exe","C:\installer\ccsetup.exe")
## Since Powershell in Windows 7 does not support the Invoke-WebRequest
