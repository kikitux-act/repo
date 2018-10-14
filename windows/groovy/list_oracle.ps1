import-module ActPowerCLI
$acthost = "172.24.1.180"
 $actuser = "jenkin01"
 $pwfile = "c:\temp\jenkin02.key"
 
 $env:IGNOREACTCERTS = $true
 
 "password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
 if (! $env:ACTSESSIONID ){
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
 }
 




$backups = $(reportapps | where-object AppType -eq "Oracle")
## $backups = $(reportapps)
 
 if (! $backups){
  write-warning "`nNo Oracle apps`n"
  break
 }

$backups | out-file "c:\temp\out.txt" 

 $message = ""
 foreach($item in $backups)
 {
 $message = '{0}' -f $item.AppName + "|" + $message
 }
 Write-Output $message
  
$message | out-file "c:\temp\out2.txt"

 if (! $env:ACTSESSIONID ){
   write-warning "Login to CDS $acthost failed"
   break
 }
 else {
   Disconnect-Act | Out-Null
 } 
