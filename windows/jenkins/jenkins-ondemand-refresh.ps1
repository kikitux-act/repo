## File: jenkins-ondemand-refresh.ps1

$pwfile = "c:\scripts\jenkin01.key"
$env:IGNOREACTCERTS = $true
 
$env:ActPassword| ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ){
  Connect-Act -acthost $Env:ActifioIP -actuser $Env:ActUser -passwordfile $pwfile -ignorecerts -quiet
}

$source_host = $env:SourceHost -replace "`n", "" 
$target_host = $env:TargetHost -replace "`n", "" 
$source_db = $env:SourceDB -replace "`n", ""
$appid = $(reportapps | where-object { $_.HostName -eq $source_host -and $_.AppName -eq $source_db }).AppID 

write-output "Kicking off an on-demand provision of virtual database $env:ORACLE_SID on $env:TargetHost using images from $source_db database `n"

udstask mountimage -appid $appid -host $env:TargetHost -label $env:ORACLE_SID -appaware -restoreoption "provisioningoptions=<provisioningoptions><databasesid>$env:ORACLE_SID</databasesid><orahome>$env:ORACLE_HOME</orahome><tnsadmindir>$env:TNSADMIN_DIR</tnsadmindir><totalmemory>$env:SGAsizeMB</totalmemory><sgapct>$env:SGApct</sgapct><username>oracle</username></provisioningoptions>,reprotect=false" -nowait | out-null

sleep -Seconds 30

$JobID = $(reportrunningjobs | where { $_.HostName -eq $source_host -And $_.AppName -eq $source_db -And $_.Target -eq $target_host -And $_.JobClass -eq 'mount(AppAware)' }).JobName
$JobStatus = $(reportrunningjobs | where { $_.JobName -eq $JobID }).status
$PrevJobPct = "0"
if ($JobStatus -eq 'running') {
  Write-Host "Job is now running.... "
  while ('running' -eq $JobStatus) {
    $JobPct = $(reportrunningjobs | where { $_.JobName -eq $JobID })."Progress%"
    if ($PrevJobPct -ne $JobPct) {
      $PrevJobPct = $JobPct
      sleep -Seconds 5
      Write-Host "- Progress% : $JobPct ..."
    } 
    $JobStatus = $(reportrunningjobs | where { $_.JobName -eq $JobID }).status
    } 
} 
sleep -Seconds 20

$start = $(udsinfo lsjobhistory $JobID).startdate
$duration = $(udsinfo lsjobhistory $JobID).duration
$vsize = $(udsinfo lsjobhistory $JobID)."Application size (GB)"
$tgthost = $(udsinfo lsjobhistory $JobID).targethost
$usedGB = $(reportmountedimages | where { $_.SourceAppID -eq $appid -And $_.MountedAppName -eq $env:ORACLE_SID } )."ConsumedSize(GB)"


 if (! $env:ACTSESSIONID ){
   write-warning "Login to CDS $Env:ActifioIP failed"
   break
 }
 else {
   Disconnect-Act | Out-Null
 } 

write-output "$env:ORACLE_SID database is successfully provisioned on $env:TargetHost !!"

write-output "Job started at $start , and took $duration to complete."
write-output "The size of $env:ORACLE_SID on $tgthost is $vsize GB, actual storage consumed in GB is $usedGB "
