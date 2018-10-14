#Registry key path 
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"

# Creates the registry entry if it doesn't exist
if (!(Test-Path $path)) {
    New-Item -Path $Path -Force | Out-Null
}

#Property name 
## ; Internet Explorer = {871C5380-42A0-1069-A2EA-08002B30309D}
## ; User's Files = {450D8FBA-AD25-11D0-98A8-0800361B1103}
## ; Computer = {20D04FE0-3AEA-1069-A2D8-08002B30309D}
## ; Network = {208D2C60-3AEA-1069-A2D7-08002B30309D}

$name = "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" 
#check if the property exists 
$item = Get-ItemProperty -Path $path -Name $name -ErrorAction SilentlyContinue 
if($item) 
{ 
    #set property value 0 = Display , 1 = Hide
    Set-ItemProperty  -Path $path -name $name -Value 0  
} 
Else 
{ 
    #create a new property 
    New-ItemProperty -Path $path -Name $name -Value 0 -PropertyType DWORD  | Out-Null  
} 
  
write-host "Operation done! But you need to refresh your desktop."

cmd /c pause 
