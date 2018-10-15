## Deploy Jenkins in a quiet mode using PowerSehell

param ()

function Expand-ZIPFile($file, $destination)
{
   $shell = new-object -com shell.application
   $zip = $shell.NameSpace($file)
   foreach($item in $zip.items()) {
      $shell.Namespace($destination).copyhere($item)
   }
}

# Path for the temporary workdir
$workdir = $env:TEMP

# To avoid getting this error. 
# "Invoke-WebRequest : The request was aborted: Could not create SSL/TLS secure channel." 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download the Actifio connector software fromt the Actifio appliance
$source = "http://mirrors.jenkins-ci.org/windows-stable/latest"
$destination = "$workdir\jenkins.zip"

# Check if Invoke-Webrequest exists otherwise execute WebClient
if (Get-Command 'Invoke-Webrequest') {
    Invoke-WebRequest $source -OutFile $destination
} else {
   $WebClient = New-Object System.Net.WebClient
   $webclient.DownloadFile($source, $destination)
}

Expand-ZIPFile –File $destination –Destination $workdir

# Kick off the installation of the Actifio connector
Start-Process -Wait -FilePath $workdir\jenkins.msi

# Wait XX Seconds for the installation to finish
Start-Sleep -s 15

# Remove the installer directory
Remove-Item $workdir\jenkins.msi -Force
Remove-Item $destination -Force
