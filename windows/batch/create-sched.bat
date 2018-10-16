:: Comment

@echo off
::@echo on

set hh=%time:~0,2%
set mm=%time:~3,2%
if %mm% GEQ 60 set /A mm=%mm%-60 && set /A hh=%hh%+1
set /A mm=%mm%+2
IF "%hh%" EQU " 1" set hh=01
IF "%hh%" EQU " 2" set hh=02
IF "%hh%" EQU " 3" set hh=03
IF "%hh%" EQU " 4" set hh=04
IF "%hh%" EQU " 5" set hh=05
IF "%hh%" EQU " 6" set hh=06
IF "%hh%" EQU " 7" set hh=07
IF "%hh%" EQU " 8" set hh=08
IF "%hh%" EQU " 9" set hh=09


if %hh% GTR 24 set hh=00
IF 1%hh% lss 100 set hh=0%hh%

IF 1%mm% lss 100 set mm=0%mm%
set hhmm=%hh%:%mm%
echo %hhmm%

if /I "%1" == "add" (
echo.Adding a job to the scheduler
schtasks /create /tn s1 /tr "c:\scripts\PS\go.bat allconnectors" /sc once /st %hhmm%
::schtasks /create /tn s1 /s auprmaw001nabwm /u aur\p766251a /p "Bourke.55" /tr "c:\scripts\PS\go.bat allconnectors" /sc once /st %hhmm%
goto eof
)

if /I "%1" == "del" (
echo.Deleting a job in the scheduler
schtasks /delete /tn s1 
goto eof
)

if /I "%1" == "ask" (
echo.Checking if the status of the defined job in the scheduler 
schtasks /query | findstr s1
goto eof
)

goto syntax

:syntax
echo.
echo. %0 add - to add a job to the scheduler
echo. %0 del - delete the scheduled job 
echo. %0 ask - query the jobs in the scheduler
echo.
:eof
