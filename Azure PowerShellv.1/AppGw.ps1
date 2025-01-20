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

$AppGw = Get-AzApplicationGateway -Name Test -ResourceGroupName Appgwtest
Start-AzApplicationGateway -ApplicationGateway $AppGw

#modified the variables before using it.