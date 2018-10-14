## list_c.ps1

param([string] $srchappdb, [string] $srchapphost)

import-module ActPowerCLI
$acthost = "172.24.1.180"
$actuser = "jenkin01"
$pwfile = "c:\scripts\jenkin02.key"
 
$env:IGNOREACTCERTS = $true
 
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ) {
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
  }
 

$mnt_hosts = $(reportmountedimages | where-object {$_.SourceApp -eq $srchappdb -And $_.SourceHost -eq $srchapphost} | select-object MountedHost)


if (! $mnt_hosts){
  write-warning "`nNo list of mounted hosts`n"
  break
  }

$mnt_hosts | out-file "c:\scripts\mnt_hosts.txt" 
$first = $true
$message = ""

foreach($item in $mnt_hosts) {
  if ($first -eq $true) {
    $first = $false
    $message = '{0}' -f $item.MountedHost
  } else {
    $message = $message + "|" + '{0}' -f $item.MountedHost
  }
}

Write-Output $message
$message | out-file "c:\scripts\mnt_hosts2.txt"

if (! $env:ACTSESSIONID ){
  write-warning "Login to CDS $acthost failed"
  break
} else {
  Disconnect-Act | Out-Null
} 
