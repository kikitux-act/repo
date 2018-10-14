## File: vmware_output_list_vms.ps1
##

Import-Module -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue -Verbose:$false
Set-PowerCLIConfiguration -InvalidCertificateAction ignore -DisplayDeprecationWarnings:$false -Verbose:$false -confirm:$false | out-null
$WarningPreference ="SilentlyContinue"

$vCenterIP = "10.65.5.23"

Connect-Viserver $vCenterIP -user administrator@vsphere.local -password 12!Pass345  | out-null

$list = ""
$first = $true

$vms = get-vm | select name

foreach ($item in $vms) {
  if ($first -eq $true) {
    $first = $false
    $list = '{0}' -f $item.Name
  } else {
    $list = $list + "," + '{0}' -f $item.Name
  }

}

write-output $list
Disconnect-VIserver -server $vCenterIP -Confirm:$false | out-null
