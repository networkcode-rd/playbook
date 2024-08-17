$resourceGroup = "Az-rd-104"
$location = "southeastasia"
$storagename = "azurestudy104rd"
$storagesku = "Standard_RAGRS"
$kind = "StorageV2"

$storageinformation = New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storagename -Skuname $storagesku -Location $location -Kind $kind

#======================== Delete Storage Account

Remove-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storagename
