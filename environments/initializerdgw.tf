#variable "subscription_id" { default = ""}
#variable "client_id" {default = ""}
#variable "client_secret" {default = ""}
#variable "tenant_id" {default = ""}

#provider "azurerm" {
#  subscription_id = "${var.subscription_id}"
#  client_id       = "${var.client_id}"
#  client_secret   = "${var.client_secret}"
#  tenant_id       = "${var.tenant_id}"
#}

#terraform {
#  backend "azurerm" {
#    storage_account_name = "fgterratest"
#    container_name       = "testing"
#    key                  = ""
#    access_key           = ""
#  }
#}

# Create a bastion setup
 module "m-rdgw-az"
{
  source   = "../Modules/rdgw/"
  prefix = "${var.prefix}"
  instance_size = "${var.instance_size}"
  instance_count = "${var.instance_count}"
  bastion_rg_name = "${var.bastion_rg_name}"
  bastion_lb_name = "${var.bastion_lb_name}"
  bastion_public_ip_name = "${var.bastion_public_ip_name}"
  bastion_subnet_name = "${var.bastion_subnet_name}"
  vnet_name = "${var.vnet_name}"
  location = "${var.location}"
  adminpass = "${var.adminpass}"
}
