## list_dbappname.ps1

param([string] $srchapptype)

import-module ActPowerCLI
$acthost = "172.24.1.180"
$actuser = "jenkin01"
$pwfile = "c:\scripts\jenkin02.key"
 
$env:IGNOREACTCERTS = $true
 
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ) {
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
  }
 

$dbappname = $(reportapps | where-object {$_.AppType -eq $srchapptype} | select-object AppName)


if (! $dbappname){
  write-warning "`nNo list of database names`n"
  break
  }

$dbappname | out-file "c:\scripts\dbappname.txt" 
$first = $true
$message = ""

foreach($item in $dbappname) {
  if ($first -eq $true) {
    $first = $false
    $message = '{0}' -f $item.AppName
  } else {
    $message = $message + "|" + '{0}' -f $item.AppName
  }
}

Write-Output $message
$message | out-file "c:\scripts\dbappname2.txt"

if (! $env:ACTSESSIONID ){
  write-warning "Login to CDS $acthost failed"
  break
} else {
  Disconnect-Act | Out-Null
}