
$name = Read-Host "What should the OVA be named? (abl-lnx03)"
if (!$name) {Write-Host "No name found.`n";Exit}
$ova = Read-Host "Where is the OVA located? (z:\export\abl-lnx01.ova)"
if ((Get-Item $ova).Name -notlike "*.ova") {Write-Host "No OVA found.`n";Exit}

#Gathering information regarding the hard disk format of the OVA being deployed in a menu format
Write-Host "`nStorage Format."
$smenu = @{}
$f=1
Write-Host "$f. Thick Provision Lazy Zeroed"
$smenu.Add($f,"Thick")
$f++
Write-Host "$f. Thick Provision Eager Zeroed"
$smenu.Add($f,"EagerZeroedThick")
$f++
Write-Host "$f. Thin Provision"
$smenu.Add($f,"Thin")

[int]$sans = Read-Host 'Enter desired storage format'
if ($sans -eq '0' -or $sans -gt $f) {Write-Host -ForegroundColor Red  -Object "Invalid selection.`n";Exit}
$hdformat = $smenu.Item($sans)


#Creating variables dependant on above input including VMhost, Resource Pool and Datastore
$vmhost = Get-VMhost | sort Name
#if ($vmhost -is [System.Array]) {
#Data store was determined to be an array. Gathering information regarding the desired resource pool
Write-Host "`nVM Host selection."
$vmmenu = @{}
for ($i=1;$i -le $vmhost.count; $i++) {
    Write-Host "$i. $($vmhost[$i-1].name)"
    $vmmenu.Add($i,($vmhost[$i-1].name))
    }
[int]$vmans = Read-Host 'Enter desired VM host.'
if ($vmans -eq '0' -or $vmans -gt $i) {Write-Host -ForegroundColor Red  -Object "Invalid selection.`n";Exit}
$vmselection = $vmmenu.Item($vmans)
$vmhost = get-vmhost $vmselection
#}



#Creating variables dependant on above input including VMhost, Resource Pool and Datastore
$ds = Get-Datastore | sort Name
if ($ds -is [System.Array]) {
#Data store was determined to be an array. Gathering information regarding the desired resource pool
Write-Host "`nData Store selection."
$dsmenu = @{}
for ($i=1;$i -le $ds.count; $i++) {
    Write-Host "$i. $($ds[$i-1].name)"
    $dsmenu.Add($i,($ds[$i-1].name))
    }
[int]$dsans = Read-Host 'Enter desired datastore.'
if ($dsans -eq '0' -or $dsans -gt $i) {Write-Host -ForegroundColor Red  -Object "Invalid selection.`n";Exit}
$dsselection = $dsmenu.Item($dsans)
$ds = get-datastore $dsselection
}

#Creating the VM based off the above information
write-host 'Import-VApp -Name ' $name
write-host '-Source ' $ova 
write-host '-VMHost ' $vmhost 
write-host '-Location ' $rp
write-host '-Datastore ' $ds
write-host ' -DiskStorageFormat ' $hdformat 
write-host ' -Confirm:$false | Out-Null'

Import-VApp -Name $name -Source $ova -VMHost $vmhost -Datastore $ds -DiskStorageFormat $hdformat -Confirm:$true
