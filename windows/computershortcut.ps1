# $TargetFile = "$env:SystemRoot\explorer.exe"
# $ShortcutFile = "$env:Userprofile\Desktop\Computer.lnk"

# $WshShell = New-Object -ComObject WScript.Shell
# $Shortcut = $WshShell.CreateShortcut($ShortcutFile)
# $Shortcut.TargetPath = $TargetFile
# $Shortcut.Arguments = "\/e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
# $Shortcut.Save()

#Registry key path 
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

if (!(Test-Path $path)) {
    New-Item -Path $Path -Force | Out-Null
}

#Property name 
$name = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 
#check if the property exists 
$item = Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue 
if($item) 
{ 
    #set property value 
    Set-ItemProperty  -Path $path -name $name -Value 0  
} 
Else 
{ 
    #create a new property 
    New-ItemProperty -Path $path -Name $name -Value 0 -PropertyType DWORD  | Out-Null  
} 
 
 
write-host "Operation done! But you need to refresh your desktop."
 
 
cmd /c pause 
