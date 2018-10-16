reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServicesOnce
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunServices

reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce

reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run

reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run

reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce 

reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

reg query "HKCU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run\COM Service"

reg query "HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"


@echo off
echo Inspecting the values of Run and RunOnce 

reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\RunonceEx

reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Run
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce
