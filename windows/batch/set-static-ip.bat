@echo off
echo Setting static IP of 192.168.2.88
netsh int ipv4 set address "Local Area Connection" static 192.168.2.88 255.255.255.0 192.168.2.1 1
echo Setting primary DNS server to 192.168.2.1
REM netsh int ipv4 set dnsservers "Local Area Connection" address=192.168.2.1 index=1
netsh int ipv4 set dns name="Local Area Connection" source=static address=202.188.0.133
netsh int ipv4 add dns name="Local Area Connection" address=202.188.1.5 
