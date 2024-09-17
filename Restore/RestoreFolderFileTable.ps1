#Installing the Az.Storage module
Install-Module Az.Storage -Repository PSGallery -Force
Import-Module Az.Storage

#connecting to Azure
Connect-AzAccount

#changing the context
Get-AzContext -ListAvailable | Select-Object -Property *

Settinmg the context using the proper subscription id
Set-AzContext -SubscriptionId 'Your SubscritionId from the previous step'

#Creating the storage context to be used during the discovery and the restore
$ctx = New-AzStorageContext -StorageAccountName 'onelake' -UseConnectedAccount -endpoint 'fabric.microsoft.com' 

#Getting the list: Deleted files/folders
Get-AzDataLakeGen2DeletedItem -Context $ctx -FileSystem 'your workspace' -Path 'yourlakehouse.lakehouse' | Select Path, DeletionId

#Restoring the file/folders
Restore-AzDataLakeGen2DeletedItem -Context $ctx -FileSystem 'your workspace'  -Path 'path from the previous' -DeletionId *yourdeletionid from the previous step*
