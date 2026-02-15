variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "sql_db_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
}

variable "sql_db_sku" {
  description = "SQL Database SKU"
  type        = string
}

variable "allowed_ip_address" {
  description = "IP address allowed to connect to SQL Server"
  type        = string
}

variable "firewall_rule_name" {
  description = "Name for the IP firewall rule"
  type        = string
  default     = "allow-verification-ip"
}

variable "key_vault_id" {
  description = "ID of the Key Vault to store secrets"
  type        = string
}

variable "sql_admin_name_secret" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
}

variable "sql_admin_password_secret" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}