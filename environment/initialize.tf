# Create a resource group

module "AzureSoftDelete"
{
  source   = "./modules"
  AzureLocation = "${var.AzureLocation}"
  StorageAccountName = "${var.StorageAccountName}"
  ResourceGroupName = "${var.ResourceGroupName}"
  TenantId = "${var.TenantId}"
  AzureSubscriptionId = "${var.AzureSubscriptionId}"
  pw = "${var.pw}"
  appid = "${var.appid}"
}
