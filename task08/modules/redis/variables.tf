variable "redis_name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "capacity" {
  description = "Redis Cache capacity"
  type        = number
}

variable "family" {
  description = "Redis Cache family"
  type        = string
}

variable "sku_name" {
  description = "Redis Cache SKU"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID for storing secrets"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the Key Vault secret for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Name of the Key Vault secret for Redis primary key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}