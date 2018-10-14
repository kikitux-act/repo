## File: vmware_set_ip.ps1
##

Add-pssnapin VMWare.VimAutomation.Core
Set-PowerCLIConfiguration -InvalidCertificateAction ignore -confirm:$false 

# Connect to the vCentre server
connect-viserver -server 10.61.5.88 -user root -password password

# Ask for the credential of the Administrator on the VM
$cred = Get-Credential Administrator

Get-VMGuestNetworkInterface  -vm zdemo-sql3 -GuestCredential $cred -Name "Local Area Connection" | Set-VMGuestNetworkInterface -IPPolicy Static -Ip 10.61.5.166 -Netmask 255.255.255.0 -Gateway 10.61.5.254 -DNS 10.61.5.161 -GuestCredential $cred
# Get-VMGuestNetworkInterface  -vm zdemo-sql3 -GuestCredential $cred -Name "Local Area Connection" | Set-VMGuestNetworkInterface -IPPolicy Dhcp -GuestCredential $cred

Get-VMGuestNetworkInterface  -vm zdemo-sql3 -GuestCredential $cred  -Name "Local Area Connection"
