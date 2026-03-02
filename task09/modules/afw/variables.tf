# Azure Firewall Module Variables

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the existing virtual network"
}

variable "firewall_subnet_address_prefix" {
  type        = string
  description = "Address prefix for the Azure Firewall subnet"
}

variable "firewall_name" {
  type        = string
  description = "Name of the Azure Firewall"
}

variable "firewall_sku_name" {
  type        = string
  description = "SKU name for the Azure Firewall"
}

variable "firewall_sku_tier" {
  type        = string
  description = "SKU tier for the Azure Firewall"
}

variable "public_ip_name" {
  type        = string
  description = "Name of the public IP for Azure Firewall"
}

variable "route_table_name" {
  type        = string
  description = "Name of the route table"
}

variable "aks_subnet_id" {
  type        = string
  description = "ID of the AKS subnet for route table association"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "Public IP address of the AKS load balancer"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "application_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name             = string
      source_addresses = list(string)
      target_fqdns     = list(string)
      protocol = list(object({
        port = string
        type = string
      }))
    }))
  }))
  description = "Application rule collections for Azure Firewall"
}

variable "network_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      source_addresses      = list(string)
      destination_addresses = list(string)
      destination_ports     = list(string)
      protocols             = list(string)
    }))
  }))
  description = "Network rule collections for Azure Firewall"
}

variable "nat_rules" {
  type = list(object({
    name     = string
    priority = number
    rules = list(object({
      name               = string
      source_addresses   = list(string)
      destination_ports  = list(string)
      protocols          = list(string)
      translated_address = string
      translated_port    = string
    }))
  }))
  description = "NAT rule collections for Azure Firewall"
}