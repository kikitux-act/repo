Set-Service -Name msiscsi -StartupType Automatic

Start-Service msiscsi


## To view iSCSI Connections:
## Get-iSCSIConnection


## Listing the iSCSI IQN for the iSCSI Initiator
## (Get-InitiatorPort).NodeAddress
