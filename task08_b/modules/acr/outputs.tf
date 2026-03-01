output "id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "The login server of the Azure Container Registry"
  value       = azurerm_container_registry.this.login_server
}

output "admin_username" {
  description = "The admin username of the Azure Container Registry"
  value       = azurerm_container_registry.this.admin_username
}

output "admin_password" {
  description = "The admin password of the Azure Container Registry"
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}

output "image_name" {
  description = "The full image name including registry"
  value       = "${azurerm_container_registry.this.login_server}/${var.image_name}:latest"
}

output "task_id" {
  description = "The ID of the Container Registry Task"
  value       = azurerm_container_registry_task.build.id
}
