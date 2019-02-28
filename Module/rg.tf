resource "azurerm_resource_group" "bastion_rg" {
  name     = "${var.bastion_rg_name}"
  location = "${var.location}"
}

output "resource_group_name" {

    value = "${azurerm_resource_group.bastion_rg.name}"
}
