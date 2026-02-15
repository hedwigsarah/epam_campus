output "app_hostname" {
  description = "Default hostname of the Linux Web App"
  value       = azurerm_linux_web_app.app.default_hostname
}

output "app_id" {
  description = "ID of the Linux Web App"
  value       = azurerm_linux_web_app.app.id
}

output "asp_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.asp.id
}