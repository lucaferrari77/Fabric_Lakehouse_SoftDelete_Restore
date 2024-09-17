# Microsoft Fabric Lakehouse & Soft delete
This set of scripts will help you restoring a file, a folder or a table accidentally dropped from a MS Fabric lakehouse.

# Pre-requisites
1. [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)
2. [Az.Storage module for Powershell](https://www.powershellgallery.com/packages/Az.Storage/3.7.0)

# Soft delete for OneLake files

OneLake soft delete protects individual files from accidental deletion by retaining files for a default retention period before it's permanently deleted. The current default is 28 days but starting May 2024 we are transitioning to a 7-day default retention period, so new workspaces will have this updated period. All soft-deleted data is billed at the same rate as active data.

For more details: [https://learn.microsoft.com/en-us/fabric/onelake/onelake-disaster-recovery#soft-delete-for-onelake-files](https://learn.microsoft.com/en-us/fabric/onelake/onelake-disaster-recovery#soft-delete-for-onelake-files)

