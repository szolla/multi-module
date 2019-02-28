variable "adminpass" {}

variable "prefix" {
  default = "FG"
}

variable "instance_size" {
  default = "Standard_B1s"
}

variable "instance_count" {
  default = "2"
}

variable "bastion_rg_name" {
  default = "BASTION_HOST_RG"
}

variable "bastion_lb_name" {
  default = "BASTION_LB"
}

variable "bastion_public_ip_name" {
  default = "BASTION_PUBLIC_IP"
}

variable "bastion_subnet_name" {
  default = "BASTION_SUBNET"
}

variable "vnet_name" {
  default = "Testing-vnet"
}

variable "location" {
  default = "CentralUS"
}
