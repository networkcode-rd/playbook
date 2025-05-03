Connect-AzAccount #initialize Authentication which will lead you to a browser based Auth.
Get-AzSubscription # to understand after Authentication, you are logged in to which Subscription, in case if your organization has multiple subscription and you haven't set the default subscription of your choice
Select-AzSubscription -Subscription xxxxxxxxxxxxxxxxxxxxxx # Use this to select the right subscription ID before making any changes. You can cross-verify the subscription ID by checking into your Azure account or check-in with your administrator or refer link: https://learn.microsoft.com/en-us/azure/azure-portal/get-subscription-tenant-id

# Use the below command to either check the version of your PowerShell installed in your computer or upgrade it.
$PSVersionTable
winget install --id Microsoft.Powershell --source winget

#Always refer to the official documentation before upgrading to the latest versoin, reference: https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4

#=========================== Till this step we have confirmed we have logged into Azure Subscription successfully and now we are good to start with any deployment using PowerShell========

#use to hide the path: function prompt{"PS >"}
#pushing this configuration
#abced


#======================================================
Connect-AzAccount -Tenant xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#or 
Connect-AzAccount
#Then
Select-AzSubscription -Subscription xxxxxxxxxxxxxxxxxxxxxx
#Validate
Get-AzContext
#Proceed. Considering the VPN Gateway is already created.

$gateway = Get-AzVirtualNetworkGateway -Name "VPN-gw" -ResourceGroupName "application-testing"
$gateway.BgpSettings.Asn = 4259860126
#Apply the changes
Set-AzVirtualNetworkGateway -VirtualNetworkGateway $gateway

#Verify the update
$gateway = Get-AzVirtualNetworkGateway -Name "VPN-gw" -ResourceGroupName "application-testing"
$gateway.BgpSettings.Asn

