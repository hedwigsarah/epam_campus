variable "name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Key Vault"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
