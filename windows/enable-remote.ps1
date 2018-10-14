# Allow RDP Connections to this computer
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name fDenyTSConnections -Value 0
# Require Network Level Authentication
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name UserAuthentication -Value 0

# Allow the Remote Desktop firewall exception
# Set-NetFirewallRule -DisplayGroup 'Remote Desktop' -Enabled True
