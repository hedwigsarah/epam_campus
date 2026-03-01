output "id" {
  description = "The ID of the Azure Container App"
  value       = azurerm_container_app.this.id
}

output "name" {
  description = "The name of the Azure Container App"
  value       = azurerm_container_app.this.name
}

output "fqdn" {
  description = "The FQDN of the Azure Container App"
  value       = azurerm_container_app.this.ingress[0].fqdn
}

output "environment_id" {
  description = "The ID of the Azure Container App Environment"
  value       = azurerm_container_app_environment.this.id
}

output "identity_principal_id" {
  description = "The principal ID of the User Assigned Identity"
  value       = azurerm_user_assigned_identity.aca.principal_id
}
