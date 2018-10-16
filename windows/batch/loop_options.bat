@ECHO OFF
:TOP

IF (%1) == () GOTO END
ECHO %1

SHIFT
GOTO TOP

:END
ECHO End

::  Sample Ouptut:
::  C:\>.\script.bat aaa bbb
::  aaa
::  bbb
::  End
