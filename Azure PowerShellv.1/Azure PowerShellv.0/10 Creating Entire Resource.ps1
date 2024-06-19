#building an entire script of creating VM and assiging NSG to it
#add new line

$resourceGroup="app-grp"
$networkName="app-network"
$location="Australia East"
$AddressPrefix="10.4.0.0/16"
$subnetName="SubnetA"
$subnetAddressPrefix="10.4.0.0/24"

$subnet=New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix -Subnet $subnet

$publicIPAddress="app-ip"

$publicIPAddress=New-AzPublicIpAddress -Name $publicIPAddress -ResourceGroupName $resourceGroup `
-Location $location -AllocationMethod Dynamic

$networkInterfaceName="app-interface"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$subnet=Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetName

$networkInterface=New-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup -Location $location `
-SubnetId $subnet.Id -IpConfigurationName "IpConfig"

#Attach the Public IP address to the Network Interface
$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $networkInterface
$networkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $publicIPAddress `
-Name $IpConfig.Name

$networkInterface | Set-AzNetworkInterface

$networkSecurityGroupName="app-nsg"

$nsgRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 120 -SourceAddressPrefix Internet -SourcePortRange * `
-DestinationAddressPrefix 10.4.0.0/24 -DestinationPortRange 3389

$nsgRule2=New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 130 -SourceAddressPrefix Internet -SourcePortRange * `
-DestinationAddressPrefix 10.4.0.0/24 -DestinationPortRange 80

$networkSecurityGroup=New-AzNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $resourceGroup `
-Location $location -SecurityRules $nsgRule1,$nsgRule2

#Attach the NSG to the subnet
Set-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $networkSecurityGroup -AddressPrefix $subnetAddressPrefix

$VirtualNetwork | Set-AzVirtualNetwork

$availabilitySetName="app-set"
$availabiltySet=New-AzAvailabilitySet -Location $location -ResourceGroupName $resourceGroup `
-Name $availabilitySetName -Sku aligned `
-PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 5

$vmName="appvm"
$VMSize="Standard_DS2_v2"

$Credential=Get-Credential

$vmConfig=New-AzVMConfig -Name $vmName -VMSize $VMSize -AvailabilitySetId $availabiltySet.Id
Set-AzVMOperatingSystem -VM $vmConfig -ComputerName $vmName -Credential $Credential -Windows

Set-AzVMSourceImage -VM $vmConfig -PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" -Skus "2022-Datacenter" -Version "latest"

$networkInterfaceName="app-interface"
$networkInterface=Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup

$Vm=Add-AzVMNetworkInterface -VM $vmConfig -Id $networkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $Vm

New-AzVM -ResourceGroupName $resourceGroup -Location $Location -VM $Vm
