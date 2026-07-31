# Connect to Azure
Connect-AzAccount
 
# Import required module
Import-Module ImportExcel
 
# ✅ Read input Excel
$saInput = Import-Excel "SAnames.xlsx"
 
$result = @()
$subscriptions = Get-AzSubscription
 
foreach ($sub in $subscriptions) {
    Set-AzContext -SubscriptionId $sub.Id
 
    foreach ($inputSA in $saInput) {
 
        $sa = Get-AzStorageAccount -ErrorAction SilentlyContinue |
              Where-Object { $_.StorageAccountName -eq $inputSA."Storage Account" }
 
        if ($sa) {
 
            $ctx = $sa.Context
 
            # Private Endpoint
            $pe = Get-AzPrivateEndpointConnection -PrivateLinkResourceId $sa.Id -ErrorAction SilentlyContinue
            $peStatus = if ($pe) { "Yes" } else { "No" }
 
            # Containers
            try {
                $containers = Get-AzStorageContainer -Context $ctx -ErrorAction Stop |
                              Select-Object -ExpandProperty Name
            } catch {
                $containers = @("Access Denied")
            }
 
            # File Shares
            try {
                $fileshares = Get-AzStorageShare -Context $ctx -ErrorAction Stop |
                              Select-Object -ExpandProperty Name
            } catch {
                $fileshares = @("Access Denied")
            }
 
            # Tables
            try {
                $tables = Get-AzStorageTable -Context $ctx -ErrorAction Stop |
                          Select-Object -ExpandProperty Name
            } catch {
                $tables = @("Access Denied")
            }
 
            # Queues
            try {
                $queues = Get-AzStorageQueue -Context $ctx -ErrorAction Stop |
                          Select-Object -ExpandProperty Name
            } catch {
                $queues = @("Access Denied")
            }
 
            # Format content
            $contentDetails = ""
 
            $contentDetails += "Container - " + (($containers) -join "`n                     ") + "`n"
            $contentDetails += "File share - " + (($fileshares) -join "`n                     ") + "`n"
            $contentDetails += "Tables - " + (($tables) -join ", ") + "`n"
            $contentDetails += "Queue - " + (($queues) -join ", ")
 
            # Add to output
            $result += [PSCustomObject]@{
                "Storage Account" = $sa.StorageAccountName
                "Environment"     = $inputSA.Environment
                "Private Endpoint Enabled" = $peStatus
                "Content details" = $contentDetails
                "Subscription"    = $sub.Name
                "Resource Group"  = $sa.ResourceGroupName
            }
        }
    }
}
 
# ✅ Export output
$result | Export-Excel -Path "SAnames_Output.xlsx" -AutoSize
