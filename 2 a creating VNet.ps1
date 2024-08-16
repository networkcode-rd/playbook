$resourceGroup="app-grp"
$location="North Europe"

New-AzResourceGroup -Name $resourceGroup -Location $location


$resourceGroup="app-grp"
$location="North Europe"
$networkName="app-network"
$AddressPrefix="10.0.0.0/16"

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix