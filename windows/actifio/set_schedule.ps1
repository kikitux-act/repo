param($appname=$null, $hostname=$null, $expirationoff=$null)

if (! $appname -Or ! $hostname -Or ! $expirationoff){
    write-host "`nUsage: .\set_schedule.ps1 <appname> <hostname> <expirationoff>`n`n"
    write-host "`nExample: .\set_schedule.ps1 TBSData aupr3sq070nabwi.aur.national.com.au true`n`n"
    break
}

$hostid = $(udsinfo lshost -filtervalue "hostname=$hostname").id
if (! $hostid ){
    write-warning "`nHost Not Found`n"
    break
}

$appid = $(udsinfo lsapplication -filtervalue "appname=$appname&hostid=$hostid").id
if (! $appid ){
    write-warning "`nApp Not Found`n"
    break
}

$slaid = $(udsinfo lssla -filtervalue "appid=$appid").id
write-host "udstask chsla -expirationoff $expirationoff $slaid "
if ($expirationoff) {
write-host "Turning off expiration for $appname"
} else {
write-host "Turning on expiration for $appname"
}
udstask chsla -expirationoff $expirationoff $slaid