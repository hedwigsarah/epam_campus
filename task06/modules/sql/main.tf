resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin_password.result
  tags                         = var.tags
}

resource "azurerm_mssql_database" "sql_db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = var.sql_db_sku
  tags      = var.tags
}

# Firewall rule to allow Azure services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Firewall rule to allow specific IP address
resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name             = var.firewall_rule_name
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}

# Store SQL admin username in Key Vault
resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = var.sql_admin_name_secret
  value        = var.sql_admin_username
  key_vault_id = var.key_vault_id
}

# Store SQL admin password in Key Vault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.sql_admin_password_secret
  value        = random_password.sql_admin_password.result
  key_vault_id = var.key_vault_id
}