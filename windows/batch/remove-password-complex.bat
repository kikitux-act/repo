::  -- https://vlasenko.org/2011/04/27/removing-password-complexity-requirements-from-windows-server-2008-core/
::  -- Removing Password Complexity Requirements from Windows Server 2008 Core
::  --

secedit /export /cfg c:\new.cfg
${c:new.cfg}=${c:new.cfg} | % {$_.Replace('PasswordComplexity=1', 'PasswordComplexity=0')}
secedit /configure /db $env:windir\security\new.sdb /cfg c:\new.cfg /areas SECURITYPOLICY
del c:\new.cfg
