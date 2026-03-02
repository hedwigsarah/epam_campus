# Azure Firewall Module Outputs

output "firewall_id" {
  description = "ID of the Azure Firewall"
  value       = azurerm_firewall.firewall.id
}

output "firewall_name" {
  description = "Name of the Azure Firewall"
  value       = azurerm_firewall.firewall.name
}

output "firewall_public_ip" {
  description = "Public IP address of the Azure Firewall"
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "firewall_private_ip" {
  description = "Private IP address of the Azure Firewall"
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

output "firewall_subnet_id" {
  description = "ID of the Azure Firewall subnet"
  value       = azurerm_subnet.firewall_subnet.id
}

output "route_table_id" {
  description = "ID of the route table"
  value       = azurerm_route_table.aks_route_table.id
}

output "public_ip_id" {
  description = "ID of the public IP"
  value       = azurerm_public_ip.firewall_pip.id
}
