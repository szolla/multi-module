# Read the JSON payload from stdin
$jsonpayload = [Console]::In.ReadLine()

# Convert JSON to a string
$json = ConvertFrom-Json $jsonpayload


$TenantId = $json.TenantId
$AzureSubscriptionId = $json.AzureSubscriptionId
$appid = $json.appid
$StorageAccountName = $json.StorageAccountName
$ResourceGroupName = $json.ResourceGroupName
$AzureLocation = $json.AzureLocation
$pw = $json.pw

# Write-Error "Something went wrong"
# exit 1
# Create a password that can be used as an application key
# Create the service AAD application

 $apppw =  ConvertTo-SecureString -String $pw -AsPlainText -Force
 $cred = New-Object System.Management.Automation.PSCredential ($appid, $apppw)
Connect-AzAccount -Credential $cred -ServicePrincipal -Tenant $TenantId -WarningAction SilentlyContinue -Subscription $AzureSubscriptionId | Out-Null

# Connect to your Azure AD directory.
#Connect-AzureAD -Tenantid $TenantId -ApplicationID "83263510-2d4b-4305-81c9-5dc09fb94292" -CertificateThumbprint "0FD79F0B98C03140B3D2374FC4F8B5A72D5F8723" | Out-Null

#Enable Soft Delete
$MatchingAccounts = Get-AzStorageAccount | where-object{$_.StorageAccountName -match $storageAccountName}
$MatchingAccounts | Enable-AzStorageDeleteRetentionPolicy -RetentionDays 7

# Write output to stdout
 Write-Output "{ ""storageaccountname"" : ""$MatchingAccounts""}"
