resource "azurerm_public_ip" "bastion_public_ip" {
  name                         = "Bastion-Public-IP"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.bastion_rg.name}"
  allocation_method            = "Static"
  sku                          = "Standard"

  tags {
    environment = "Production"
  }
}
