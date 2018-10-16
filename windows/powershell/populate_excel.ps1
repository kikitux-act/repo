#########################################################
# File: PopExcel.ps1
#
# Extracts information from an Actifio appliance using ActPowerCLI into an Excel spreadsheet
# Requires MS Excel, PowerShell and ActPowerCLI to be installed on the system
#
#########################################################

# If parameter is not specified, set it to $null. Make sure this is the first line in the PowerShell script.
param($outputfilename=$null)

if (! $outputfilename)
{
     write-host "`nUsage: $scriptName ExcelFileName`n" -ForegroundColor Yellow
     break
}

###############################
# Set runtime parameters      #
###############################
$xlCenter=-4108

$acthost = "10.61.5.114"
$actuser = "admin"
$pwfile = "c:\temp\password.key"

# Connect to Actifio
#
$env:IGNOREACTCERTS = $true
write-host "`nConnecting to Actifio ($acthost)..." 
if (! $env:ACTSESSIONID ){
     connect-act -acthost $acthost -actuser $actuser -passwordfile $pwfile -ignorecerts -quiet
}

if (! $env:ACTSESSIONID ){
     write-warning "Unable to login to Actifio ($acthost)!!"
     break
}

# Stores the output of "udsinfo lsuser" into the "Users" worksheet
#
Function store_user()
{

	$sheet = $workbook.Sheets.Add()
	$sheet.Name = "Users"

	$num_rows = 1
	$sheet.cells.Item($num_rows,1) = "ID"
	$sheet.cells.Item($num_rows,2) = "CLI enabled"
	$sheet.cells.Item($num_rows,3) = "Full Name"
	$sheet.cells.Item($num_rows,4) = "Time Zone"
	$sheet.cells.Item($num_rows,5) = "Login Name"
	$sheet.cells.Item($num_rows,6) = "Deny Login"

	$sheet.rows.item("1:1").Font.Bold=$True
	$sheet.rows.item("1:1").Font.size=11
	$sheet.rows.item("1:1").Font.Name="Calibri"
	$sheet.rows.item("1:1").HorizontalAlignment = $xlcenter
	$range = $sheet.Range("A1","F1")
# 1=black, 2=white
	$range.Font.ColorIndex=2
	$range.Interior.ColorIndex=1

	udsinfo lsuser | ForEach-Object {
		$num_rows ++
		$sheet.cells.Item($num_rows,1) = $($_.id)
		$sheet.cells.Item($num_rows,2) = $($_.clienabled)
		$sheet.cells.Item($num_rows,3).Formula = "=concatenate($([char]34)$($_.firstname)$([char]34),$([char]34)$([char]32)$([char]34),$([char]34)$($_.lastname)$([char]34))"
		$sheet.cells.Item($num_rows,4) = $($_.timezone)
		$sheet.cells.Item($num_rows,5) = $($_.name)
		$sheet.cells.Item($num_rows,6) = $($_.denylogin)
	}

	$usedRange = $Sheet.UsedRange 
	$usedRange.EntireColumn.AutoFit() | Out-Null 
}

# Stores the output of reportapps into the "Apps" worksheet
#
Function store_apps()
{
	$sheet = $workbook.Sheets.Add()
	$sheet.Name = "Apps"

	$num_rows = 1
	$sheet.cells.Item($num_rows,1) = "AppName"
	$sheet.cells.Item($num_rows,2) = "AppType"
	$sheet.cells.Item($num_rows,3) = "MDLStat(GB)"
	$sheet.cells.Item($num_rows,4) = "Template"
	$sheet.cells.Item($num_rows,5) = "Profile"
	$sheet.cells.Item($num_rows,6) = "Stage(GB)"
	$sheet.cells.Item($num_rows,7) = "Total(GB)"
	$sheet.cells.Item($num_rows,8) = "HostName"

	$sheet.rows.item("1:1").Font.Bold=$True
	$sheet.rows.item("1:1").Font.size=11
	$sheet.rows.item("1:1").Font.Name="Calibri"
	$sheet.rows.item("1:1").HorizontalAlignment = $xlcenter
	$range = $sheet.Range("A1","H1")
# 1=black, 2=white
	$range.Font.ColorIndex=2
	$range.Interior.ColorIndex=1

	reportapps | ForEach-Object {
		$num_rows ++
		$sheet.cells.Item($num_rows,1) = $($_.appname)
		$sheet.cells.Item($num_rows,2) = $($_.apptype)
		$sheet.cells.Item($num_rows,3) = $($_."MDLStat(GB)")
		$sheet.cells.Item($num_rows,4) = $($_."Template")
		$sheet.cells.Item($num_rows,5) = $($_."Profile")
		$sheet.cells.Item($num_rows,6) = $($_."Stage(GB)")
		$sheet.cells.Item($num_rows,7) = $($_."Total(GB)")
		$sheet.cells.Item($num_rows,8) = $($_."HostName")
	}

	$usedRange = $Sheet.UsedRange 
	$usedRange.EntireColumn.AutoFit() | Out-Null
}

############################################
#
# Main Body
#

# Creates a new Excel object
#
$excel = New-Object -ComObject Excel.Application

# Make Excel visible in case if you need to troubleshoot the script
$excel.Visible = $true

# Do not show confirmation 
$excel.DisplayAlerts = $False

$workbook = $excel.Workbooks.Add()

# Remove Sheet2 and Sheet3 from the workbook
$Worksheet2 = $workbook.Sheets | Where {$_.Name -eq "Sheet2"}
$Worksheet2.Delete()
$Worksheet3 = $workbook.Sheets | Where {$_.Name -eq "Sheet3"}
$Worksheet3.Delete()

store_user

store_apps

$workbook.SaveAs($outputfilename)
$excel.Quit()

write-host "`nYour output is in $outputfilename ..." 
