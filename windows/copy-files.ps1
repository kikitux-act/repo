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
