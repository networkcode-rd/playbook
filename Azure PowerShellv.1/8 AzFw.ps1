#================== Set Operation on Azure Firewall =========================
$azFw = Get-AzFirewall -Name "AzureFirewall" -ResourceGroupName "rg"
$ruleCollection = $azFw.GetApplicationRuleCollectionByName("ruleCollectionName")
$ruleCollection.Priority = 101
Set-AzFirewall -AzureFirewall $azFw

#reference: https://learn.microsoft.com/en-us/powershell/module/az.network/set-azfirewall?view=azps-12.4.0

#================== Deallocate and Allocate Azure Firewall ============================

# Stop an existing firewall

$azfw = Get-AzFirewall -Name "FW Name" -ResourceGroupName "RG Name"
$azfw.Deallocate()
Set-AzFirewall -AzureFirewall $azfw

# Start the firewall

$azfw = Get-AzFirewall -Name "FW Name" -ResourceGroupName "RG Name"
$vnet = Get-AzVirtualNetwork -ResourceGroupName "RG Name" -Name "VNet Name"
$publicip1 = Get-AzPublicIpAddress -Name "Public IP1 Name" -ResourceGroupName "RG Name"
$publicip2 = Get-AzPublicIpAddress -Name "Public IP2 Name" -ResourceGroupName "RG Name"
$azfw.Allocate($vnet,@($publicip1,$publicip2))

Set-AzFirewall -AzureFirewall $azfw

#============================================================================