variable "name" {
  description = "The name of the Azure Container App"
  type        = string
}

variable "environment_name" {
  description = "The name of the Azure Container App Environment"
  type        = string
}

variable "location" {
  description = "The Azure region where the ACA will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}

variable "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  type        = string
}

variable "image" {
  description = "The Docker image to deploy"
  type        = string
}

variable "redis_hostname_secret_id" {
  description = "The ID of the Redis hostname secret in Key Vault"
  type        = string
}

variable "redis_password_secret_id" {
  description = "The ID of the Redis password secret in Key Vault"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
