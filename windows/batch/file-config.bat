@echo on

rem remove unnecessary files from users homedrive. The folder needs to be there though.
if not exist \\%COMPUTERNAME%\HOME\%USERNAME% md \\%COMPUTERNAME%\HOME\%USERNAME% >NUL: 2>&1
if exist \\%COMPUTERNAME%\HOME\%USERNAME%\UID.INI echo y | del \\%COMPUTERNAME%\HOME\%USERNAME%\*.*
net use K: \\%COMPUTERNAME%\HOME\%USERNAME%

if not exist \\%COMPUTERNAME%\HOME\%USERNAME%\APP.X md \\%COMPUTERNAME%\HOME\%USERNAME%\APP.X
xcopy c:\DATA\TEMPLATE\APP.X\*.* K: /S /E /Y

if not exist "K:\UID.CFG" Goto noecho
Ren K:\UID.CFG UID.OLD >Nul: 2>&1

:noecho
echo UserName=%USERNAME% > K:\UID.CFG

:done
net use K: /D
