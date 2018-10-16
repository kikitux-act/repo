@echo off
set path=%path%;%~dp0
set sw=HKLM\SOFTWARE
set u=Microsoft\Windows\CurrentVersion\Uninstall
set k=7-Zip

setlocal EnableDelayedExpansion

rem check native version of 7-Zip
reg query "%sw%\%u%" /s | find "%k%" > nul 2>&1
if !errorlevel!==0 set mark4uninstall=1

rem check 32-bit version on 64-bit windows
if not "%ProgramFiles(x86)%"=="" (
reg query "%sw%\Wow6432Node\%u%" /s | find "%k%" > nul 2>&1
if !errorlevel!==0 set mark4uninstall=1
)

rem if 7-Zip is installed then execute uninstall scenario
if "%mark4uninstall%"=="1" (
echo %k% found
echo.

rem execute scenarion which are supossed to run on 64-bit windows only
if not "%ProgramFiles(x86)%"=="" (
echo this is 64-bit windows
echo.

rem look for 32-bit version on 64-bit windows
echo looking for 32-bit version on 64-bit system..
echo.

for /f "tokens=8 delims=\" %%a in ('^
reg query "%sw%\Wow6432Node\%u%" /s ^| find "\Uninstall\"') do (
reg query "%sw%\Wow6432Node\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 (
reg query "%sw%\Wow6432Node\%u%\%%a" /v DisplayName | find "%k%" > nul 2>&1
if !errorlevel!==0 (

echo %%a | find "{" > nul 2>&1
rem uninstall using msiexec
if !errorlevel!==0 (
echo Auto uninstalling using:
echo "%systemroot%\system32\msiexec.exe /X %%a /qn"
%systemroot%\system32\msiexec.exe /X %%a /qn
echo.
) else echo %k% was installed using exe installer

echo %%a | find "{" > nul 2>&1
rem search for uninstall string
if not !errorlevel!==0 (
echo.
for /f "tokens=*" %%u in ('^
reg query "%sw%\Wow6432Node\%u%\%%a" /v UninstallString ^|
findstr "UninstallString" ^|
sed "s/UninstallString\|REG_SZ//g" ^|
sed "s/^[ \t]*//g" ^|
sed "s/\d034//g"') do (
echo found %k% 32-bit version on 64-bit system
reg query "%sw%\Wow6432Node\%u%\%%a" /v DisplayVersion | find "DisplayVersion"
echo.
echo Auto uninstalling using:
echo "%%u" /S
"%%u" /S
)
echo.

rem double check if registry is clear
:recheck32
echo %time%
reg query "%sw%\Wow6432Node\%u%\%%a" > nul 2>&1
if !errorlevel!==0 goto recheck32
) else echo %k% was installed using msi installer
echo.

)
)
)
) else echo this is 32-bit windows

rem execute scenario to uninstall native version
rem this will uninstall 64-bit version on 64-bit windows
rem this will uninstall 32-bit version on 32-bit windows

rem look for native version
echo look for native version..
echo.

for /f "tokens=7 delims=\" %%a in ('^
reg query "%sw%\%u%" /s ^| find "\Uninstall\"') do (
reg query "%sw%\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 (
reg query "%sw%\%u%\%%a" /v DisplayName | find "%k%" > nul 2>&1
if !errorlevel!==0 (

echo %%a | find "{" > nul 2>&1
rem uninstall using msiexec
if !errorlevel!==0 (
echo Auto uninstalling using:
echo "%systemroot%\system32\msiexec.exe /X %%a /qn"
%systemroot%\system32\msiexec.exe /X %%a /qn
echo.
) else echo %k% was installed using exe installer
echo %%a | find "{" > nul 2>&1
rem search for uninstall string
if not !errorlevel!==0 (
echo.
for /f "tokens=*" %%u in ('^
reg query "%sw%\%u%\%%a" /v UninstallString ^|
findstr "UninstallString" ^|
sed "s/UninstallString\|REG_SZ//g" ^|
sed "s/^[ \t]*//g" ^|
sed "s/\d034//g"') do (
echo found native version of %k%
reg query "%sw%\%u%\%%a" /v DisplayVersion | find "DisplayVersion"
echo.
echo Auto uninstalling using:
echo "%%u" /S
"%%u" /S
)
echo.
rem double check if registry is clear
:recheck
echo %time%
reg query "%sw%\%u%\%%a" > nul 2>&1
if !errorlevel!==0 goto recheck
) else echo %k% was installed using msi installer
echo.
)
)
)
) else echo 7-Zip not installed
endlocal
pause
