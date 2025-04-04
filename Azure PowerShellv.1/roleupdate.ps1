# Connect to Azure account (if not already logged in)
Connect-AzAccount

# Define the role name to update
$roleName = "YourExistingRoleName"

# Get the existing role definition
$roleDefinition = Get-AzRoleDefinition -Name $roleName

# Update the role's actions
$roleDefinition.Actions = @(
    "Microsoft.Network/virtualWans/*",
    "Microsoft.Network/virtualHubs/*",
    "Microsoft.Network/azureFirewalls/read",
    "Microsoft.Network/networkVirtualAppliances/*/read",
    "Microsoft.Network/securityPartnerProviders/*/read",
    "Microsoft.Network/expressRouteGateways/*",
    "Microsoft.Network/vpnGateways/*",
    "Microsoft.Network/p2sVpnGateways/*",
    "Microsoft.Network/virtualNetworks/peer/action",
    "Microsoft.Network/virtualNetworks/join/action", 
    "Microsoft.Network/virtualHubs/hubVirtualNetworkConnections/delete",
    "Microsoft.Network/virtualHubs/routeMaps/read",
    "Microsoft.Network/virtualhubs/hubRouteTables/read",
    "Microsoft.Network/virtualHubs/hubVirtualNetworkConnections/write",
    "Microsoft.Network/virtualHubs/hubVirtualNetworkConnections/read"
)

# Apply the updated role definition
Set-AzRoleDefinition -Role $roleDefinition

Write-Host "Role '$roleName' has been successfully updated."