# Quick shortcut creation script

# This if the variable that will hold the computer name of your target device
$computer = "sqlboot" 
# This command will create the shortcut object
$WshShell = New-Object -ComObject WScript.Shell
# This is where the shortcut will be created
$Shortcut = $WshShell.CreateShortcut("$env:Userprofile\Desktop\sgo.lnk")
# This is the program the shortcut will open
$Shortcut.TargetPath = "C:\windows\system32\bin\cmd.exe"

# Network drive icon
# $Shortcut.IconLocation = "%SystemRoot%\System32\imageres.dll,28"

# This is the icon location that the shortcut will use
# $Shortcut.IconLocation = "%SystemRoot%\System32\imageres.dll,68"

$Shortcut.IconLocation = "%SystemRoot%\System32\imageres.dll,62"

# This is any extra parameters that the shortcut may have. For example, opening to a google.com when internet explorer opens
$Shortcut.Arguments = " /k ""powershell -noexit """"connect-act -acthost 172.24.16.192 -actuser admin -password password -ignorecerts"""""" "
# This command will save all the modifications to the newly created shortcut.
$Shortcut.Save()
