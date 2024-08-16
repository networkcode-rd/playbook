#building an entire script of creating VM and assiging NSG to it
# Updated file. Use this file only for practice.

# First make sure that your PS console is authenticated to Azure Cloud.
Connect-AzAccount -TenantId xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# After authentication is successful, make sure the prompt that appeard with the "Subscription Name", is the right subscription you will be working on. If not, to get the list of subscription ID or Subscription name that is dedicated for your work purpose, use the below command and follow by verify command to make sure you are in the right subscription to make read/write changes.

Get-AzSubscription

#To verify
Get-AzContext #Till this point we made sure we are in the right subscription.

#Verify your Azure PowerShell version by running
$PSVersionTable #To undestand which version you should be working on us the link: https://learn.microsoft.com/en-us/powershell/azure/install-azps-windows?view=azps-12.2.0&tabs=powershell&pivots=windows-psgallery

#Pre-configuration verfication

# (1) To select the right region for deployment use:
Get-AzLocation | Format-Table


# Let's build a Azure VM.

#Declared Variable.

$resourceGroup="Az-rd-104"
$networkName="VNet-104-A"
$location="southeastasia"
$AddressPrefix="10.4.0.0/16"
$subnetName="SubnetA"
$subnetAddressPrefix="10.4.0.0/24"

New-AzResourceGroup -Name $resourceGroup -Location $location #Creating RG

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix -Subnet $subnet

$subnet=New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix

# ----------------- Verify the resource creation until now by running these commmands ---------------------------

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
