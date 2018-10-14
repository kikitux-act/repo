# Quick shortcut creation script

# This if the variable that will hold the computer name of your target device
$computer = "sqlboot" 
# This command will create the shortcut object
$WshShell = New-Object -ComObject WScript.Shell
# This is where the shortcut will be created
$Shortcut = $WshShell.CreateShortcut("$env:Userprofile\Desktop\Jenkins.lnk")
# This is the program the shortcut will open
$Shortcut.TargetPath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
# This is the icon location that the shortcut will use
# $Shortcut.IconLocation = "C:\Windows\System32\SHELL32.dll,13"
# This is any extra parameters that the shortcut may have. For example, opening to a google.com when internet explorer opens
$Shortcut.Arguments = "http://localhost:8080"
# This command will save all the modifications to the newly created shortcut.
$Shortcut.Save()
