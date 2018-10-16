$ErrorActionPreference = "SilentlyContinue"
$vmlist = Import-CSV C:\temp\vmlist.csv

Connect-VIServer 172.24.50.99 -user train\michael.chew -password 12!pass345 | out-null

foreach ($vm in $vmlist) {
# Is the VM running and VMware tools installed?
    $currVM = Get-VM $vm.name
    if ( ! $currVM ) {
        Write-Host "ERROR: VM " $vm.name " is missing !!!" -Background Red -ForegroundColor DarkRed
    } else {
# Check whether VM is running and VMware Tools is installed
        if ( $currVM.PowerState -ne "PoweredOff" ) {
            if ( $currVM.guest.extensiondata.ToolsVersion -ne 0  ) {
                $interface = Get-VMGuestNetworkInterface -VM $vm.name -GuestUser $vm.username -GuestPassword $vm.password | ?{ $_.Name -eq $vm.netname}
                if ($vm.ip -eq "0.0.0.0") {
                    write-host "Changing IP address to DHCP on: " $vm.name
                    Set-VMGuestNetworkInterface -VMGuestNetworkInterface $interface -IPPolicy Dhcp -DnsPolicy Dhcp -GuestUser $vm.username -GuestPassword $vm.password  | out-null
                } else {
                    write-host "Changing IP address to static on: " $vm.name
                    Set-VMGuestNetworkInterface -VMGuestNetworkInterface $interface -IPPolicy Static -ip $vm.ip -Netmask $vm.mask -Gateway $vm.gateway -DNS $vm.primarydns,$vm.secondarydns -GuestUser $vm.username -GuestPassword $vm.password | out-null
                }
            } else {
                write-host " * * Unable to change IP address on " $vm.name " !! VMware tools is not installed." -Background Red -ForegroundColor DarkRed
            }
        } else {
            write-host " * * Unable to change IP address on " $vm.name " !! The VM is powered OFF." -Background Red -ForegroundColor DarkRed
        }
    }
}

Disconnect-VIServer -Confirm:$false
