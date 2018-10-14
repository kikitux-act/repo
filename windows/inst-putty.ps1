$MachineName= gc env:computername
## C:\Windows\System32\net.exe use "\\RemoteMachine\SharedFolder\DotnetFrameWork 4.0" password /user:domain\username 

## C:\Windows\System32\net.exe use "\\10.61.5.162\public" p@ssw0rd /user:mdemo\administrator 

C:\Windows\System32\net.exe use "\\10.61.5.162\public"

if (!(Test-Path "C:\Temp"))
{
   New-Item -Path "C:\Temp" -ItemType directory
}
    
Copy-Item -Path "\\10.61.5.162\public\winsoftware\putty-0.65-installer.exe" -Destination "C:\Temp" -Force -Recurse  

$FileName = "C:\Temp\putty-0.65-installer.exe" 
$CommandLineArgs = "/silent"

Write-Host "Starting process $FileName on machine $($MachineName)"
$p = Start-Process -FilePath $FileName -ArgumentList $CommandLineArgs -Wait -PassThru
Write-Host "The process $FileName exit code is $($p.exitcode)"
