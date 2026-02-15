variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cmaz-7ymyr7zc-mod6"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US 2"
}

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
  default     = "sqladmin"
}

variable "allowed_ip_address" {
  description = "IP address allowed to connect to SQL Server"
  type        = string
}

variable "kv_resource_group_name" {
  description = "Resource group name for existing Key Vault"
  type        = string
  default     = "cmaz-7ymyr7zc-mod6-kv-rg"
}

variable "kv_name" {
  description = "Name of existing Key Vault"
  type        = string
  default     = "cmaz-7ymyr7zc-mod6-kv"
}

variable "sql_admin_name_secret" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
  default     = "sql-admin-name"
}

variable "sql_admin_password_secret" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
  default     = "sql-admin-password"
}

variable "sql_db_sku" {
  description = "SQL Database service model/SKU"
  type        = string
  default     = "S2"
}

variable "asp_sku" {
  description = "App Service Plan SKU"
  type        = string
  default     = "P0v3"
}

variable "dotnet_version" {
  description = "Dotnet version for Web App"
  type        = string
  default     = "8.0"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Creator = "sarah-hedwig_popescu@epam.com"
  }
}