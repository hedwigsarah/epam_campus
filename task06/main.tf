# Data source for existing Key Vault
data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_resource_group_name
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

# SQL Module
module "sql" {
  source = "./modules/sql"

  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  sql_server_name           = local.sql_server_name
  sql_db_name               = local.sql_db_name
  sql_admin_username        = var.sql_admin_username
  sql_db_sku                = var.sql_db_sku
  allowed_ip_address        = var.allowed_ip_address
  firewall_rule_name        = "allow-verification-ip"
  key_vault_id              = data.azurerm_key_vault.kv.id
  sql_admin_name_secret     = var.sql_admin_name_secret
  sql_admin_password_secret = var.sql_admin_password_secret
  tags                      = var.tags
}

# Web App Module
module "webapp" {
  source = "./modules/webapp"

  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  asp_name              = local.asp_name
  app_name              = local.app_name
  asp_sku               = var.asp_sku
  dotnet_version        = var.dotnet_version
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags

  depends_on = [module.sql]
}