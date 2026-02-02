output "vm_public_ip" {
  description = "Public IP address of the Virtual Machine"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_fqdn" {
  description = "Fully Qualified Domain Name of the Virtual Machine"
  value       = azurerm_public_ip.main.fqdn
}