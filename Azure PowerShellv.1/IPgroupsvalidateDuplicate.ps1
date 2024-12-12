$ipGroups = Get-AzIpGroup -ResourceGroupName Cx-rg-CI -Name TestingRG


foreach ($ipGroup in $ipGroups) {
    Write-Host "Checking IP Group: $($ipGroup.Name)"
    $ipAddresses = $ipGroup.IpAddresses
    $duplicates = $ipAddresses | Group-Object | Where-Object { $_.Count -gt 1 }

    if ($duplicates) {
        Write-Host "Duplicate IPs found in IP Group $($ipGroup.Name):"
        $duplicates | ForEach-Object { Write-Host $_.Name }
    } else {
        Write-Host "No duplicate IPs found in IP Group $($ipGroup.Name)"
    }
}

$ipGroupName = "TestingRG"
$resourceGroupName = "Cx-rg-CI"

# Get the IP group
$ipGroup = Get-AzIpGroup -Name $ipGroupName -ResourceGroupName $resourceGroupName

# Get unique IP addresses
$uniqueIps = $ipGroup.IpAddresses | Sort-Object | Get-Unique

# Update the IP group with unique IP addresses
Set-AzIpGroup -IpGroup $ipGroup -ResourceGroupName $resourceGroupName -IpAddress $uniqueIps


# Get unique IP addresses
$uniqueIps = $ipGroup.IpAddresses | Sort-Object | Get-Unique

# Update the IP group with only unique IP addresses
Set-AzIpGroup -Name $ipGroupName -ResourceGroupName $resourceGroupName -IpAddress $uniqueIps
Set-AzIpGroup -IpGroup $ipGroup -ResourceGroupName $resourceGroupName -IpAddress $uniqueIps


#================================================================
Install-Module -Name ImportExcel -Scope CurrentUser
$ipGroupName = "TestingRG"
$resourceGroupName = "Cx-rg-CI"

# Get the IP group
$ipGroup = Get-AzIpGroup -Name $ipGroupName -ResourceGroupName $resourceGroupName

# Extract the IP addresses
$ipAddresses = $ipGroup.IpAddresses | ForEach-Object { [PSCustomObject]@{ IPAddress = $_ } }

$outputFile = "C:\C.O.D.E\Output.xlsx"  # Replace with your desired file path
$ipAddresses | Export-Excel -Path $outputFile -AutoSize