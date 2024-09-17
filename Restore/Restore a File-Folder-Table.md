# How to restore a dropped file/folder/table in a MS Fabric Lakehouse

In case you need to restore a file, folder or a table dropped less than 7 days ago, you can use this approach.

1. If not available, install the Az.Storage module: [Install-Module](https://learn.microsoft.com/en-us/powershell/module/az.tools.installer/install-azmodule?view=aztools) Az.Storage -Repository PSGallery.
2. Connect to your Azure environment using the [Connect-AzAccount](https://learn.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount?view=azps-12.3.0) and the proper account when required.
![](/Restore/Images/Connect-AzAccount.png)
3. Change the Azure context if needed using the [Get-AzContext -ListAvailable | Select-Object -Property *](https://learn.microsoft.com/en-us/powershell/azure/context-persistence?view=azps-12.3.0)
![](/Restore/Images/Get-AzContext.png)
4. Take note of the Subscription you want to connect to.
5. Set the context: [Set-AzContext](https://learn.microsoft.com/en-us/powershell/azure/context-persistence?view=azps-12.3.0) -SubscriptionId 'your subscription id'
![](/Restore/Images/Set-AzContext.png)
6. Create the storage context required to list deleted files/folders: $ctx = [New-AzStorageContext](https://learn.microsoft.com/en-us/powershell/module/servicemanagement/azure.storage/new-azurestoragecontext?view=azuresmps-4.0.0) -StorageAccountName 'onelake' -UseConnectedAccount -endpoint 'fabric.microsoft.com'
7. Take note of the Path and the DeletionId for the file/folder you want to restore using: [Get-AzDataLakeGen2DeletedItem](https://learn.microsoft.com/en-us/powershell/module/az.storage/get-azdatalakegen2deleteditem?view=azps-12.3.0) -Context $ctx -FileSystem 'your workspace name' -Path 'yourlakehousename.lakehouse' | Select Path, DeletionId.
![](/Restore/Images/getdeletedfiles.png)
8. Restore the file running this: [Restore-AzDataLakeGen2DeletedItem](https://learn.microsoft.com/en-us/powershell/module/az.storage/restore-azdatalakegen2deleteditem?view=azps-11.6.0) -Context $ctx -FileSystem 'yourworkspacename'  -Path 'path to the file' -DeletionId deletionId 
![](/Restore/Images/Restore-File.png)

The complete Powershell script is available [here](/Restore/RestoreFolderFileTable.ps1).

# Notes

Az.Storage assumes that the name of the MS Fabric workspace adhere to the [Azure Storage naming rules](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules#microsoftstorage). If you named your MS Fabric workspace using capitalized names the exploration will fail.
![](/Restore/Images/UnsupportedName.png)

In this case you can use the WorkspaceId and the lakehouseId from the url from the Fabric portal
![](/Restore/Images/idfromurl.png)

and use them in the powershell script

![](/Restore/Images/RestoreUnsupportedName.png)
