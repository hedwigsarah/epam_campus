variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
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

variable "subnet_frontend_name" {
  description = "Name of the frontend subnet"
  type        = string
}

variable "subnet_frontend_prefix" {
  description = "Address prefix for the frontend subnet"
  type        = string
}

variable "subnet_backend_name" {
  description = "Name of the backend subnet"
  type        = string
}

variable "subnet_backend_prefix" {
  description = "Address prefix for the backend subnet"
  type        = string
}

variable "creator_tag" {
  description = "Creator tag value"
  type        = string
}