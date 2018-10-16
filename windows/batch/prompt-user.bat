@echo off
if ["%1"]==[""] goto usage
"C:\Program Files (x86)\PuTTY\putty.exe" -v -load "act01-dp" -m %1
@echo.
@echo Your output is in c:\log\act01-dp.log
set /p question=Do you want to list the output (Y/[N])?
if /I "%question%" neq "Y" goto :eof
type c:\log\act01-dp.log
goto :eof

:usage
@echo To run CLI commands on Actifio in Deer Park, place all commands in input-file
@echo  Usage: %0 input-file
