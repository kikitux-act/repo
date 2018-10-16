:: Finally create an event in the Event Log
EVENTCREATE /T INFORMATION /L SYSTEM /ID 999 /SO Advance /D "Standard.cmd Version %StandardVersion% script implemented on %computername%" 
