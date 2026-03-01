variable "name" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "The Azure region where the ACR will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "image_name" {
  description = "The name of the Docker image to build"
  type        = string
}

variable "context_path" {
  description = "The URL path to the build context (blob URL)"
  type        = string
}

variable "context_access_token" {
  description = "The SAS token for accessing the build context"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
