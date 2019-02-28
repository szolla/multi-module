variable "availability_zone" {
  #There are only 3 availability zones per region currently
  default = ["1", "2", "3"]
}

resource "azurerm_network_interface" "rdgw_host_ip" {
  count               = "${var.instance_count}"
  name                = "${var.prefix}-nic-${format("rdgw-%02d", count.index + 1)}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.bastion_rg.name}"

  ip_configuration {
    name                          = "ipconfig${format("-rdgw-%02d", count.index + 1)}"
    subnet_id                     = "${azurerm_subnet.bastion_subnet.id}"
    private_ip_address_allocation = "dynamic"
    #public_ip_address_id          = "${azurerm_public_ip.main.id}"
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = "${azurerm_subnet.bastion_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.rdgw_nsg.id}"
}

resource "azurerm_virtual_machine" "rdgw_host" {
  count                 = "${var.instance_count}"
  name                  = "${format("rdgw-%02d", count.index + 1)}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.bastion_rg.name}"
  network_interface_ids = ["${element(azurerm_network_interface.rdgw_host_ip.*.id, count.index)}"]
  vm_size               = "${var.instance_size}"
  zones                 = ["${element(var.availability_zone, count.index)}"]
  
  # comment this line to not delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true
  # Uncomment this line to not delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "OS-${format("rdgw-%02d", count.index + 1)}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "rduser"
    admin_password = "${var.adminpass}"
  }
  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent = true
  }
  tags {
    environment = "testing"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                   = "${var.instance_count}"
  network_interface_id    = "${element(azurerm_network_interface.rdgw_host_ip.*.id, count.index)}"
  ip_configuration_name   = "ipconfig${format("-rdgw-%02d", count.index + 1)}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.rdgw_pool.id}"
}


