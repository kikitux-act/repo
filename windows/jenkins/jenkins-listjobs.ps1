##

param (
[string]$JenkinsIP = ""
)

JenkinsUser='michael.chew'
JenkinsCode='6e9f2efd59a3f11d41607fc16424817f'

if ($JenkinsIP -eq "") {
  $JenkinsIP  = Read-Host -Prompt 'Please enter the Actifio IP address '
} 

# Path for the temporary workdir
$workdir = $env:TEMP

# Download the installer

$source = "http://$JenkinsIP:8080/jnlpJars/jenkins-cli.jar"
$destination = "$workdir\jenkins-cli.jar"

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
Start-Process -FilePath "C:\Program Files (x86)\Jenkins\jre\bin\java.exe" -ArgumentList "-jar $destination -s http://$JenkinsUser:$JenkinsCode@$JenkinsIP:8080/ list-jobs "

# Wait XX Seconds for the installation to finish
Start-Sleep -s 15

# Remove the installer directory
Remove-Item $destination -Force
