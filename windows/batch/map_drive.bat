@Echo Off

if /I %UserName% NEQ Administrator (
	if exist H: (NET USE H: /DELETE>NUL)
	if not exist "\\SR-XP-XA6\USHARE\%UserName%" (
		MD \\SR-XP-XA6\USHARE\%UserName% )
	NET USE H: \\SR-XP-XA6\USHARE\%UserName% /PERSISTENT:NO>NUL
	)
