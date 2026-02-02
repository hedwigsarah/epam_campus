variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "Address prefix for the subnet"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "nsg_rule_http_name" {
  description = "Name of the HTTP NSG rule"
  type        = string
}

variable "nsg_rule_ssh_name" {
  description = "Name of the SSH NSG rule"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "dns_name_label" {
  description = "DNS name label for the public IP"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "vm_admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "vm_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "creator_tag" {
  description = "Creator tag value"
  type        = string
}