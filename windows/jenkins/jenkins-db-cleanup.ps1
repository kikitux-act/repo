## File: jenkins-db-cleanup.ps1

$pwfile = "c:\scripts\jenkin01.key"
$env:IGNOREACTCERTS = $true
 
$env:ActPassword| ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File $pwfile
 
if (! $env:ACTSESSIONID ){
  Connect-Act -acthost $Env:ActifioIP -actuser $Env:ActUser -passwordfile $pwfile -ignorecerts -quiet
}

$src_host = $env:SourceHost -replace "`n", "" 
$src_db = $env:SourceDB -replace "`n", "" 
$tgt_host = $env:TargetHost -replace "`n", "" 
$mnt_db = $env:TargetDB -replace "`n", "" 


$cmd = $(reportmountedimages | where-object { $_.SourceHost -eq $src_host -And $_.SourceApp -eq $src_db -And $_.MountedHost -eq $tgt_host -And $_.MountedAppName -eq $mnt_db }).UnmountDeleteCommand

write-output "Unmounting the $mnt_db DB on $tgt_host `n"
Invoke-Expression $cmd | out-null

sleep -Seconds 15

$JobID = $(reportrunningjobs | where { $_.HostName -eq $src_host -And $_.AppName -eq $src_db -And $_.Target -eq $tgt_host }).JobName
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

write-output 'Job completed successfully !!'

if (! $env:ACTSESSIONID ){
   write-warning "Login to CDS $Env:ActifioIP failed"
   break
 }
 else {
   Disconnect-Act | Out-Null
 } 
