variable "name" {
  description = "The name of the Azure Container Instance"
  type        = string
}

variable "location" {
  description = "The Azure region where the ACI will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Instance"
  type        = string
  default     = "Standard"
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to store secrets"
  type        = string
}

variable "key_vault_access_policy_id" {
  description = "The ID of the Key Vault access policy (used for dependency)"
  type        = string
}

variable "redis_password_secret_name" {
  description = "The name of the Key Vault secret for Redis password"
  type        = string
  default     = "redis-password"
}

variable "redis_hostname_secret_name" {
  description = "The name of the Key Vault secret for Redis hostname"
  type        = string
  default     = "redis-hostname"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
