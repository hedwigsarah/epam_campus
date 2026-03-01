output "id" {
  description = "The ID of the Azure Kubernetes Service"
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "The name of the Azure Kubernetes Service"
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  description = "The Kubernetes configuration"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "The Kubernetes API server URL"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
}

output "client_certificate" {
  description = "The client certificate for authentication"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive   = true
}

output "client_key" {
  description = "The client key for authentication"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kubelet_identity_client_id" {
  description = "The client ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].client_id
}

output "kubelet_identity_object_id" {
  description = "The object ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

output "secret_provider_identity_client_id" {
  description = "The client ID of the Key Vault secrets provider identity"
  value       = azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}
