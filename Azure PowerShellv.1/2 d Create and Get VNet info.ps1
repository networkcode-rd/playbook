$resourceGroup="Az-rd-104"
$networkName="VNet-104-A"
$location="southeastasia"
$AddressPrefix="10.4.0.0/16"
$subnetName="SubnetA"
$subnetAddressPrefix="10.4.0.0/24"

$VirtualNetwork=New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix

Write-Host $VirtualNetwork.AddressSpace.AddressPrefixes
Write-Host $VirtualNetwork.Location