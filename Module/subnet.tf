resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${var.bastion_subnet_name}"
  resource_group_name  = "${azurerm_resource_group.bastion_rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "10.0.2.0/24"
}
