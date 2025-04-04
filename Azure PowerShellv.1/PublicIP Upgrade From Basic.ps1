Install-Module -Name AzureVMPublicIPUpgrade -Scope CurrentUser -Repository PSGallery -Force
Connect-AzAccount -Tenant <TenantId> -Subscription <SubscriptionId>
Start-VMPublicIPUpgrade -VMName 'myVM' -ResourceGroupName 'myRG'