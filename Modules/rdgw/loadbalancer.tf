#Creaet Standard Public Load balancer
resource "azurerm_lb" "bastion_lb" {
  name                = "${var.bastion_lb_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.bastion_rg.name}"
  sku                 = "Standard"


  frontend_ip_configuration {
    name                 = "bastion_ip"
    public_ip_address_id = "${azurerm_public_ip.bastion_public_ip.id}"
    #subnet_id            = "${azurerm_subnet.bastion.id}"
  }
}

resource "azurerm_lb_probe" "rdgw_probe" {
  resource_group_name = "${azurerm_resource_group.bastion_rg.name}"
  loadbalancer_id     = "${azurerm_lb.bastion_lb.id}"
  name                = "rdgw-running-probe"
  port                = 3389
  protocol            = "Tcp"
}

resource "azurerm_lb_rule" "rdgw_rule" {
  resource_group_name            = "${azurerm_resource_group.bastion_rg.name}"
  loadbalancer_id                = "${azurerm_lb.bastion_lb.id}"
  name                           = "LB-RDGW-Rule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "bastion_ip"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.rdgw_pool.id}"
  probe_id                       = "${azurerm_lb_probe.rdgw_probe.id}"
}

resource "azurerm_lb_backend_address_pool" "rdgw_pool" {
  resource_group_name = "${azurerm_resource_group.bastion_rg.name}"
  loadbalancer_id     = "${azurerm_lb.bastion_lb.id}"
  name                = "rdgw_pool"
}
