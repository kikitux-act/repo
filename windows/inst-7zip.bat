REM http://7-zip.org/a/7z1604.msi
REM http://7-zip.org/a/7z1604-x64.msi
REM https://catonrug.blogspot.com.au/2013/10/7zip-silent-native-install.html
REM 

@echo off
set n=7-Zip
setlocal EnableDelayedExpansion
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | find "%n%"
if not !errorlevel!==0 (
echo %n%

:x64
if not "%ProgramFiles(x86)%"=="" (
for /f "delims=" %%f in ('dir /b "%~dp07z*x64.msi"') do (
%systemroot%\system32\msiexec.exe /i "%~dp0%%f" /qn
)
)

:x86
if "%ProgramFiles(x86)%"=="" (
for /f "delims=" %%f in ('dir /b "%~dp07z*.msi" ^| find /v "x64"') do (
%systemroot%\system32\msiexec.exe /i "%~dp0%%f" /qn
)
)

) else echo %n% already exists!
endlocal
