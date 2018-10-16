@echo off
CLS
 
ECHO Detecting BGInfo.exe...
IF NOT EXIST "c:\bginfo\bginfo.exe" (
ECHO Copying BGInfo.exe...
::EDIT SOURCE PATH BELOW TO MATCH YOUR ENVIRONMENT
XCOPY "\\site.domain.net\sysvol\...\Logon\bginfo.exe" "c:\bginfo\" /y /q /h
) ELSE (
ECHO c:\bginfo\bginfo.exe exists! Skipping copy...
)
 
ECHO Copying BGInfo config locally...
::EDIT SOURCE PATHS BELOW TO MATCH YOUR ENVIRONMENT
XCOPY "\\site.domain.net\sysvol\...\Logon\bg.jpg" "c:\bginfo\"  /y /q /h
XCOPY "\\site.domain.net\sysvol\...\Logon\default.bgi" "c:\bginfo\" /y /q /h
 
ECHO Copying BGInfo_Refresh.bat to Start menu...
::EDIT SOURCE PATH BELOW TO MATCH YOUR ENVIRONMENT
XCOPY "\\site.domain.net\sysvol\...\Logon\BGInfo_Refresh.bat" "%HOMEDRIVE%%HOMEPATH%\Start Menu\" /y /q /h
 
ECHO Applying BGInfo...
"C:\bginfo\bginfo.exe" "C:\bginfo\default.bgi" /TIMER:00 /NOLICPROMPT
 
ECHO Done!
