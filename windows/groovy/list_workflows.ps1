param([string] $srchappname)

$acthost = "172.24.1.180"
 $actuser = "jenkin01"
 $pwfile = "c:\temp\jenkin02.key"
 
 $env:IGNOREACTCERTS = $true
 
 "password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
 if (! $env:ACTSESSIONID ){
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
 }
 
 $appid = $(udsinfo lsapplication -filtervalue "appname=$srchappname&apptype=Oracle").id
 
 if (! $appid ){
  write-warning "`nInvalid srchappname Not Found`n"
  break
 }
 

 $backups = $(reportworkflows -a $appid)
 
 if (! $backups){
  write-warning "`nNo workflows for source application`n"
  break
 }
 
 $message = ""
 foreach($item in $backups)
 {
 $message = '{0}' -f $item.WorkflowName + "|" + $message
 }
 Write-Output $message
  
 if (! $env:ACTSESSIONID ){
   write-warning "Login to CDS $acthost failed"
   break
 }
 else {
   Disconnect-Act | Out-Null
 } 
