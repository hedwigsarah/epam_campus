data "archive_file" "app" {
  type        = "tar.gz"
  source_dir  = var.source_dir
  output_path = "${path.module}/app.tar.gz"
}

resource "time_static" "sas_start" {}

resource "time_offset" "sas_expiry" {
  offset_days = 7
}

resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.account_replication_type

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = var.container_access_type
}

resource "azurerm_storage_blob" "app" {
  name                   = "app.tar.gz"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source                 = data.archive_file.app.output_path
  content_md5            = data.archive_file.app.output_md5
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true

  start  = time_static.sas_start.rfc3339
  expiry = time_offset.sas_expiry.rfc3339

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }
}
