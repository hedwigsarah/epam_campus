output "id" {
  description = "The ID of the Traffic Manager profile"
  value       = azurerm_traffic_manager_profile.this.id
}

output "fqdn" {
  description = "The FQDN of the Traffic Manager profile"
  value       = azurerm_traffic_manager_profile.this.fqdn
}

output "name" {
  description = "The name of the Traffic Manager profile"
  value       = azurerm_traffic_manager_profile.this.name
}