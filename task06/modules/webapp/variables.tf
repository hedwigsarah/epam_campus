variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "asp_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_name" {
  description = "Name of the Web Application"
  type        = string
}

variable "asp_sku" {
  description = "App Service Plan SKU"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Web App"
  type        = string
}

variable "sql_connection_string" {
  description = "SQL Database connection string"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}