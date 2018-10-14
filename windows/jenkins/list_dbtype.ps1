## list_dbtype.ps1

import-module ActPowerCLI
$acthost = "172.24.1.180"
$actuser = "jenkin01"
$pwfile = "c:\scripts\jenkin02.key"
 
$env:IGNOREACTCERTS = $true
 
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ) {
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
  }
 

$dbtype = $(reportapps | where-object {$_.AppType -eq 'SQLServer' -or $_.AppType -eq 'Oracle'} | select-object apptype | get-unique -asstring)


if (! $dbtype){
  write-warning "`nNo database types`n"
  break
  }

$dbtype | out-file "c:\scripts\dbtype.txt" 
$first = $true
$message = ""

foreach($item in $dbtype) {
  if ($first -eq $true) {
    $first = $false
    $message = '{0}' -f $item.AppType 
  } else {
    $message = $message + "|" + '{0}' -f $item.AppType
  }
}

Write-Output $message
$message | out-file "c:\scripts\dbtype2.txt"

if (! $env:ACTSESSIONID ){
  write-warning "Login to CDS $acthost failed"
  break
} else {
  Disconnect-Act | Out-Null
} 