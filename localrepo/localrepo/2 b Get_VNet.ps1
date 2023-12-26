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