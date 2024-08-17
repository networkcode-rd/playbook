$resourceGroup="Az-rd-104"
$location="southeastasia"
$appServiceName="app-plan-rd"
$webAppName="webappnetworkcode"

New-AzAppServicePlan -ResourceGroupName $resourceGroup -Location $location -Name $appServiceName -Tier "F1"

New-AzWebApp -ResourceGroupName $resourceGroup -Name $webAppName -Location $location -AppServicePlan $appServiceName
