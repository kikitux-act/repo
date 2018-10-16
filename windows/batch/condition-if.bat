@echo off
if exist c:\script\nul.ext (
	@echo c:\scripts is there
) else (
	@echo c:\scripts is missing
	)

if exist c:\scripts\1.txt (
	@echo 1.txt
) else if exist c:\scripts\2.txt (
	@echo 2.txt
) else (
	@echo others.txt
)
