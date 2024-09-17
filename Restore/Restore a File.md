# How to restore a dropped file in a MS Fabric Lakehouse

In case you need to restore a file dropped less than 7 days ago, you can use this approach.

1. Install the Az.Storage module if not available yet: [Install-Module](https://learn.microsoft.com/en-us/powershell/module/az.tools.installer/install-azmodule?view=aztools) Az.Storage -Repository PSGallery.
2. Connect to your Azure environment using the [Connect-AzAccount](https://learn.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount?view=azps-12.3.0) and the proper account when required.
3. Change the Azure context if needed using the [Get-AzContext -ListAvailable | Select-Object -Property *](https://learn.microsoft.com/en-us/powershell/azure/context-persistence?view=azps-12.3.0)
4. Take note of the Subscription you want to connect to.
5. Set the context: [Set-AzContext](https://learn.microsoft.com/en-us/powershell/azure/context-persistence?view=azps-12.3.0) -SubscriptionId 'your subscription id'
6. Create the storage context required to list deleted files/folder: $ctx = [New-AzStorageContext](https://learn.microsoft.com/en-us/powershell/module/servicemanagement/azure.storage/new-azurestoragecontext?view=azuresmps-4.0.0) -StorageAccountName 'onelake' -UseConnectedAccount -endpoint 'fabric.microsoft.com'
7. Take note of the Path and the DeletionId for the file you want to restore using: Get-AzDataLakeGen2DeletedItem(https://learn.microsoft.com/en-us/powershell/module/az.storage/get-azdatalakegen2deleteditem?view=azps-12.3.0) -Context $ctx -FileSystem 'softdeletetest' -Path 'mylakehouse.lakehouse' | Select Path, DeletionId.
8. Restore the file running this: [Restore-AzDataLakeGen2DeletedItem](https://learn.microsoft.com/en-us/powershell/module/az.storage/restore-azdatalakegen2deleteditem?view=azps-11.6.0) -Context $ctx -FileSystem $workspaceName  -Path $DeleteItemPath -DeletionId 133709673683448292


