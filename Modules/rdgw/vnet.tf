variable "cidr_block" {
  default = "10.0.0.0/16"
}

resource "azurerm_virtual_network" "network" {
    name                = "BastionVnet"
    location            = "${var.location}"
    address_space       = ["${var.cidr_block}"]
    resource_group_name = "${azurerm_resource_group.bastion_rg.name}"
}
