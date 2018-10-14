## list_workflow.ps1

param([string] $srchapptype, [string] $srchappname)

import-module ActPowerCLI
$acthost = "172.24.1.180"
$actuser = "jenkin01"
$pwfile = "c:\scripts\jenkin02.key"
 
$env:IGNOREACTCERTS = $true
 
"password" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ) {
  Connect-Act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
  }
 
$appid = $(udsinfo lsapplication -filtervalue "appname=$srchappname&appclass=$srchapptype").id
 
if (! $appid ){
  write-warning "`nInvalid srchappname Not Found`n"
  break
  }

$workflow = $(reportworkflows -a $appid)

if (! $workflow){
  write-warning "`nNo list of database names`n"
  break
  }

$workflow | out-file "c:\scripts\workflow.txt" 
$first = $true
$message = ""

foreach($item in $workflow) {
  if ($first -eq $true) {
    $first = $false
    $message = '{0}' -f $item.WorkflowName
  } else {
    $message = $message + "|" + '{0}' -f $item.WorkflowName
  }
}

Write-Output $message
$message | out-file "c:\scripts\workflow2.txt"

if (! $env:ACTSESSIONID ){
  write-warning "Login to CDS $acthost failed"
  break
} else {
  Disconnect-Act | Out-Null
} 