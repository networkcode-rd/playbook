#========================== Stop AppGw ==================================================

Stop-AzApplicationGateway
    -ApplicationGateway <PSApplicationGateway>
    [-AsJob]
    [-DefaultProfile <IAzureContextContainer>]
    [<CommonParameters>]

#========================= Reference https://learn.microsoft.com/en-us/powershell/module/az.network/stop-azapplicationgateway?view=azps-12.5.0 ========================

$AppGw = Get-AzApplicationGateway -Name AppGwv2 -ResourceGroupName Application-testing
Stop-AzApplicationGateway -ApplicationGateway $AppGw


#========================== Start AppGw ==================================================

Start-AzApplicationGateway
-ApplicationGateway <PSApplicationGateway>
[-DefaultProfile <IAzureContextContainer>]
[<CommonParameters>]

$AppGw = Get-AzApplicationGateway -Name AppGwv2 -ResourceGroupName Application-testing
Start-AzApplicationGateway -ApplicationGateway $AppGw

#modified the variables before using it.


$AppGw = Get-AzApplicationGateway -Name AppGwv2 -ResourceGroupName Application-testing
$AppGw.FrontendIPConfigurations[0].PrivateIPAddress = "172.20.1.45"
Set-AzApplicationGateway -ApplicationGateway $AppGw

$appGateway = Get-AzApplicationGateway -Name AppGwv2 -ResourceGroupName Application-testing
$frontendIPConfig = $appGateway.FrontendIPConfigurations | Where-Object { $_.Name -eq "172.20.1.45" }
$frontendIPConfig.PrivateIPAddress = "172.20.1.45"

Set-AzApplicationGateway -ApplicationGateway $appGateway

# Get full information on your AppGw.
Get-AzApplicationGateway -Name "AppGwv2" -ResourceGroupName "Application-testing" | select * | ConvertTo-Json -Depth 100


$VNet = Get-AzVirtualNetwork -Name "layer7resources" -ResourceGroupName "Application-testing"
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name "AppGwsubnet" -VirtualNetwork $VNet
$AppGw = Get-AzApplicationGateway -Name "AppGwv2" -ResourceGroupName "Application-testing"
$AppGw = Set-AzApplicationGatewayFrontendIPConfig -ApplicationGateway $AppGw -Name "NewprivateIP" -Subnet $Subnet -PrivateIPAddress 172.20.1.46




# Update frontend private IP (PowerShell)
$appgw = Get-AzApplicationGateway -ResourceGroupName "Application-testing" -Name "AppGwv2"
$appgw.FrontendIPConfigurations[0].PrivateIPAddress = "New.Private.IP"
Set-AzApplicationGateway -ApplicationGateway $appgw
