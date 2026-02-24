variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "ACR SKU"
  type        = string
  default     = "Basic"
}

variable "image_name" {
  description = "Name of the Docker image"
  type        = string
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}