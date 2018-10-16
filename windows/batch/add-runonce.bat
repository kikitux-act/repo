@echo off
REM REG ADD HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce /v EWF /t REG_SZ /d "c:\scripts\setTimeDate.cmd"
REG ADD HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce /v EWF /t REG_SZ /d "c:\scripts\setTimeDate.cmd"
