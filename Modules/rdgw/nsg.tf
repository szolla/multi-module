resource "azurerm_network_security_group" "rdgw_nsg" {
  name                 = "RDGW_NSG"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.bastion_rg.name}"

  security_rule {
    name                       = "Public"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
