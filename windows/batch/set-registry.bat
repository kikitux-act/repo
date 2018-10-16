@echo off
@echo Windows Registry Editor Version 5.00 > MyApp.reg
@echo. >> MyApp.reg
@echo [HKEY_LOCAL_MACHINE\SOFTWARE\Net6Vpn]>> MyApp.reg
@echo "VpnGateway0"="ftl.gateway.citrix.com:443">> MyApp.reg
@echo. >> MyApp.reg
@echo [HKEY_LOCAL_MACHINE\SOFTWARE\Net6Vpn\GWURLS]>> MyApp.reg
@echo "URL1"="ftl.gateway.citrix.com:443">> MyApp.reg

regedit /s MyApp.reg
