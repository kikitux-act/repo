## File: actifio_list_vms.ps1
#
param(
[string] $ActIP,
[string] $ActUser,
[string] $ActPass)

Import-module ActPowerCLI

connect-act -acthost $ActIP -actuser $ActUser -password $ActPass -ignorecerts -quiet | out-null
$list = ""
$first = $true

foreach ($item in $(udsinfo lshost -filtervalue "isesxhost=false&isvcenterhost=false&isclusterhost=false")) {
  if ($first -eq $true) {
    $first = $false
    $list = '{0}' -f $item.HostName
  } else {
    $list = $list + "," + '{0}' -f $item.HostName
  }
}
write-output $list

disconnect-act | out-null
