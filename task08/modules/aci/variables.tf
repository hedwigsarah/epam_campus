variable "aci_name" {
  description = "Name of the Azure Container Instance"
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

variable "sku" {
  description = "ACI SKU"
  type        = string
  default     = "Standard"
}

variable "acr_login_server" {
  description = "ACR login server URL"
  type        = string
}

variable "acr_admin_username" {
  description = "ACR admin username"
  type        = string
}

variable "acr_admin_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "image_name" {
  description = "Docker image name"
  type        = string
}

variable "redis_hostname" {
  description = "Redis hostname"
  type        = string
}

variable "redis_primary_key" {
  description = "Redis primary access key"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}