$logfile = "C:\log\disClust_$(get-date -format `"yyyyMMdd_hhmmsstt`").txt"

function log($string, $color)
{
   if ($Color -eq $null) {$color = "white"}
   write-host $string -foregroundcolor $color
   $string | out-file -Filepath $logfile -append
}

Connect-Act -acthost 10.61.5.114 -actuser admin -password password -ignorecerts
$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
log "vmdiscovery started - $Stamp"
udstask vmdiscovery -host vcenter -discoverclusters
log "vmdiscovery ended - $Stamp"
Disconnect-Act
exit
