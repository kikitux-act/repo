## list_mnttgtapp.ps1

param([string] $srchappdb, [string] $srchapphost, [string] $tgtapphost)

import-module ActPowerCLI
$acthost = "172.24.1.180"
$actuser = "jenkin01"
$pwfile = "c:\scripts\jenkin02.key"
 
$env:IGNOREACTCERTS = $true
 
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ) {
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
  }
 
$mnt_apps = $(reportmountedimages | where-object {$_.SourceApp -eq $srchappdb -And $_.SourceHost -eq $srchapphost -And $_.MountedHost -eq $tgtapphost} | select-object MountedAppName)


if (! $mnt_apps){
  write-warning "`nNo list of virtual DB`n"
  break
  }

$mnt_apps | out-file "c:\scripts\mnt_apps.txt" 
$first = $true
$message = ""

foreach($item in $mnt_apps) {
  if ($first -eq $true) {
    $first = $false
    $message = '{0}' -f $item.MountedAppName
  } else {
    $message = $message + "|" + '{0}' -f $item.MountedAppName
  }
}

Write-Output $message
$message | out-file "c:\scripts\mnt_apps2.txt"


if (! $env:ACTSESSIONID ){
  write-warning "Login to CDS $acthost failed"
  break
} else {
  Disconnect-Act | Out-Null
} 
