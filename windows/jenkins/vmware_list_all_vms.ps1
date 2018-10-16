Add-PSSnapin VMware.VimAutomation.Core
Connect-Viserver 10.61.5.88 -user root -password password
Get-VM | FT -Auto
# Get-vm -name "DC" | get-networkadapter
Disconnect-VIserver -server 10.61.5.88 -Confirm:$false
exit
