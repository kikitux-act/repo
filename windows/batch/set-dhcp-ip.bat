@echo off
echo Setting Dynamic (DHCP) IP address and DNS
netsh int ipv4 set address "Local Area Connection" dhcp
netsh int ipv4 set dnsservers "Local Area Connection" dhcp
