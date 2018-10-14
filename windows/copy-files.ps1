param(
[string] $sourcedir = "c:\\temp1",
[string] $targetdir = "d:\\temp1")

$now = Get-Date
$date = Get-Date ($now) -uformat %Y%m%d
$time = Get-Date ($now) -uformat %H%M

$sourcedir = "h:\\downloads\PSoutput\$date"

$targetdir = "k:\\PSoutput\$date"
If(!(test-path $targetdir))
{
New-Item -ItemType Directory -Force -Path $targetdir | out-null
}

copy-item $sourcedir\* $targetdir

# $workdir = $env:TEMP 
# Copy-Item -Path "\\10.61.5.162\public\winsoftware\putty-0.65-installer.exe" -Destination "C:\Temp" -Force -Recurse 
# Copy-Item -Source \\server\share\file -Destination C:\path\ 
