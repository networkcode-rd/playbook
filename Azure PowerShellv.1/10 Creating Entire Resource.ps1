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

$subnet=New-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetAddressPrefix

New-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup `
-Location $location -AddressPrefix $AddressPrefix -Subnet $subnet


# ----------------- Verify the resource creation until now by running these commmands ---------------------------
Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup # Getting VNet information.

Get-AzVirtualNetworkSubnetConfig -ResourceGroupName $resourceGroup -VirtualNetworkName $networkName

# ----------------------------------------------------------------------------------------------------------------


$publicIPAddress="PublicIP104"

$publicIPAddress=New-AzPublicIpAddress -Name $publicIPAddress -ResourceGroupName $resourceGroup `
-Location $location -AllocationMethod Static

$networkInterfaceName="nic-vm-104"

$VirtualNetwork=Get-AzVirtualNetwork -Name $networkName -ResourceGroupName $resourceGroup

$subnet=Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VirtualNetwork -Name $subnetName

$networkInterface=New-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup -Location $location `
-SubnetId $subnet.Id -IpConfigurationName "IpConfig"

#Attach the Public IP address to the Network Interface
$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $networkInterface
$networkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $publicIPAddress `
-Name $IpConfig.Name
Set-AzNetworkInterface -NetworkInterface $networkInterface

#===================== Buidling NSG ====For Subnet ====================

$networkSecurityGroupName="NSG-104" #defined NSG name under a variable.

$nsgRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * `
-DestinationAddressPrefix 10.4.0.0/24 -DestinationPortRange 3389 #Creating NSG rule-1 to allow RDP access.

$nsgRule2=New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 140 -SourceAddressPrefix Internet -SourcePortRange * `
-DestinationAddressPrefix 10.4.0.0/24 -DestinationPortRange 80 #Creating NSG rule-2 to allow HTTP access.

$networkSecurityGroup=New-AzNetworkSecurityGroup -Name $networkSecurityGroupName -ResourceGroupName $resourceGroup `
-Location $location -SecurityRules $nsgRule1,$nsgRule2 # Creation of NSG rule using the two newly NSG rules and calling it under NSG creation object.

#Attach the NSG to the subnet
Set-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $networkSecurityGroup -AddressPrefix $subnetAddressPrefix

$VirtualNetwork | Set-AzVirtualNetwork


#===================== Buidling NSG ==== For NIC ====================

$nicNSG = "nic-nsg-104"

$nsgrule3 = New-AzNetworkSecurityRuleConfig -Name "Allow-RDP-Only" -Access Allow -Protocol Tcp -Direction Inbound -Priority 102 -SourceAddressPrefix * `
-SourcePortRange * -DestinationAddressPrefix 10.4.0.0/24 -DestinationPortRange 3389 #NSG rule created.

$networksecuritygroupnic = New-AzNetworkSecurityGroup -Name $nicNSG  -ResourceGroupName $resourceGroup -Location $location -SecurityRules $nsgrule3 # Till here the NSG gets created.

# Now declare the NIC variable
$networkInterfaceName = "nic-vm-104"

$nic = Get-AzNetworkInterface -Name $networkInterfaceName -ResourceGroupName $resourceGroup

$nic.NetworkSecurityGroup = $networksecuritygroupnic # link of NIC and NSG is completed. Now to update or reflect in the Azure Resource Manager or Azure Portal, use the next Set command.

Set-AzNetworkInterface -NetworkInterface $nic

#=======================Lets consider I need to update an existing rule#=======================

$networkSecurityGroup = Get-AzNetworkSecurityGroup -Name $nicNSG -ResourceGroupName $resourceGroup

Set-AzNetworkSecurityRuleConfig -Name "Allow-RDP-Only" -NetworkSecurityGroup $networkSecurityGroup `
-Description "Allow-RDP-Only" -Access Allow -Protocol Tcp -Direction Inbound -Priority 102 `
-SourceAddressPrefix 49.37.133.121 -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389


Set-AzNetworkSecurityGroup -NetworkSecurityGroup $networkSecurityGroup

=========================================================

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
