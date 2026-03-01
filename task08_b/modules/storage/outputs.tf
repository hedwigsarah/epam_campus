output "id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint of the Storage Account"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.this.name
}

output "blob_url" {
  description = "The URL of the blob"
  value       = azurerm_storage_blob.app.url
}

output "sas_token" {
  description = "The SAS token for the blob container"
  value       = data.azurerm_storage_account_blob_container_sas.this.sas
  sensitive   = true
}
