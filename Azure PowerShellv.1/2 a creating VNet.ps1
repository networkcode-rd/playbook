$resourceGroup="app-grp"
$location="North Europe"

New-AzResourceGroup -Name $resourceGroup -Location $location


$resourceGroup="app-grp"
$location="North Europe"
$networkName="app-network"
$AddressPrefix="10.0.0.0/16"

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix

#================ Fetch VNet information
Get-AzVirtualNetwork -Name VS-VNet-Server

#different Approach for fetching information

$resourceGroup="PS_RG_IC"
$networkName="VS-VNet-Server"
Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$virtuaknetworkinfo = Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup
$virtuaknetworkinfo.AddressSpace
$virtuaknetworkinfo.IpAllocations

Write-Host $virtuaknetworkinfo.AddressSpace.AddressPrefixes
Write-Host $virtuaknetworkinfo.Location