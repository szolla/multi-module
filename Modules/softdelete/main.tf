variable "TenantId" {}
variable "AzureSubscriptionId" {}
variable "StorageAccountName" {}
variable "ResourceGroupName" {}
variable "AzureLocation" {}
variable "pw" {}
variable "appid" {}

# Call Powershell.exe and pass in 'foo' and 'bar'
data "external" "azure_soft_delete" {
  program = ["Powershell.exe", "./modules/AzureSoftDelete.ps1"]

  query = {
    # Change the following values to match your deployment.
    TenantId = "${var.TenantId}"
    AzureSubscriptionId = "${var.AzureSubscriptionId}"
    StroageAccountName = "${var.StorageAccountName}"
    ResourceGroupName = "${var.ResourceGroupName}"
    AzureLocation = "${var.AzureLocation}"
    pw = "${var.pw}"
    appid = "${var.appid}"

  }
}

output "storageaccountname" {
  value = "${data.external.azure_soft_delete.result.storageaccountname}"
}
