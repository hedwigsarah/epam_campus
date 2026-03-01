output "id" {
  description = "The ID of the Azure Container Instance"
  value       = azurerm_container_group.redis.id
}

output "fqdn" {
  description = "The FQDN of the Azure Container Instance"
  value       = azurerm_container_group.redis.fqdn
}

output "ip_address" {
  description = "The IP address of the Azure Container Instance"
  value       = azurerm_container_group.redis.ip_address
}

output "redis_password" {
  description = "The Redis password"
  value       = random_password.redis.result
  sensitive   = true
}

output "redis_password_secret_id" {
  description = "The ID of the Redis password secret in Key Vault"
  value       = azurerm_key_vault_secret.redis_password.id
}

output "redis_hostname_secret_id" {
  description = "The ID of the Redis hostname secret in Key Vault"
  value       = azurerm_key_vault_secret.redis_hostname.id
}
