param(
 [string] $ActUser = 'actifio01',
 [string] $ActIP = "10.19.123.239")

$pwfile = "C:\scripts\ps\$env:USERNAME-passwd.key"

#################################
# Connect to Actifio appliance  #
#################################

$moduleins = get-module -listavailable -name ActPowerCLI
if ($moduleins -eq $null) {
    Import-Module ActPowerCLI
}

##  Save-ActPassword –filename "C:\scripts\password.key"
"password" | ConvertTo-SecureString –AsPlainText –Force | ConvertFrom-SecureString | Out-File $pwfile

connect-act -acthost $ActIP -actuser $ActUser -passwordfile $pwfile -ignorecerts

reporthealth

disconnect-act
