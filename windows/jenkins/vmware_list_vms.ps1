## File: vmware_list_vms.ps1
##

. "C:\Program Files (x86)\VMware\Infrastructure\PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1" $true | out-null

Connect-Viserver 10.65.5.23 -user administrator@vsphere.local -password 12!Pass345 | Out-Null

$vms = (get-vm | select-object name)

Disconnect-VIserver -server 10.65.5.23 -Confirm:$false | Out-Null

$vms
