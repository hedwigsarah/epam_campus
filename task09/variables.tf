# Root Module Variables

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

variable "virtual_network_address_space" {
  type        = string
  description = "Address space of the existing virtual network"
}

variable "aks_subnet_name" {
  type        = string
  description = "Name of the existing AKS subnet"
}

variable "aks_subnet_address_prefix" {
  type        = string
  description = "Address prefix of the AKS subnet"
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the existing AKS cluster"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "Public IP address of the AKS load balancer"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for resources"
}

variable "firewall_public_ip_name" {
  type        = string
  description = "Name of the firewall public IP"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
