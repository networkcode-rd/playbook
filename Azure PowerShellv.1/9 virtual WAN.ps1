# Fetch P2S Configuration details for vWAN-vHUB
#=======================================================================
Get-AzP2sVpnGateway -Name "18c5e87c34dd4b3887e74bd6db0503e1-centralindia-p2s-gw" -ResourceGroupName "Cx-rg-CI"

Get-AzP2sVpnGateway -Name "18c5e87c34dd4b3887e74bd6db0503e1-centralindia-p2s-gw" -ResourceGroupName "Cx-rg-CI" | select *

Get-AzP2sVpnGateway -Name "18c5e87c34dd4b3887e74bd6db0503e1-centralindia-p2s-gw" -ResourceGroupName "Cx-rg-CI" | select * | ConvertTo-Json -Depth 100


#================= update P2S configuration ================================

Update-AzP2sVpnGateway -ResourceGroupname "Cx-rg-CI" -name "18c5e87c34dd4b3887e74bd6db0503e1-centralindia-p2s-gw"

#==================== Reset VPN configuration ==============================

$P2Svpn = Get-AzP2sVpnGateway -Name "18c5e87c34dd4b3887e74bd6db0503e1-centralindia-p2s-gw" -ResourceGroupName "Cx-rg-CI"
Reset-AzP2sVpnGateway -p2svpngateway $P2Svpn

# Doc referred
# Link-1: https://learn.microsoft.com/en-us/powershell/module/az.network/reset-azp2svpngateway?view=azps-12.0.0
# Link-2: https://learn.microsoft.com/en-us/powershell/module/az.network/update-azp2svpngateway?view=azps-12.5.0&viewFallbackFrom=azps-12.0.0