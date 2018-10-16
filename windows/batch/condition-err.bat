@echo off 				
rem 			
rem This is a Windows Shell Script that invokes a DB2 Command Window that 			
rem performs a database backup by calling the DB2 backup database command. 			
rem 			
set DB2INSTANCE=DB2 			
set DB2DATABASE=SAMPLE		
title Starting database backup of %DB2DATABASE% on %date% at %time%... 	
DB2CMD.EXE -c -w -i DB2 BACKUP DATABASE %DB2DATABASE% 		
if not %errorlevel% == 0 ( 		
echo Database backup of %DB2DATABASE% failed,RC=%errorlevel% ) 		
else 
( 				
echo Database backup of %DB2DATABASE% completed on %date% at %time%. 				
)
