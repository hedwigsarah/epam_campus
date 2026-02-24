output "aks_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
  sensitive   = true
}

output "aks_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
  sensitive   = true
}

output "kube_config" {
  description = "The Kubernetes config"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "host" {
  description = "The Kubernetes host"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive   = true
}

output "client_certificate" {
  description = "The client certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
}

output "client_key" {
  description = "The client key"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kubelet_identity_client_id" {
  description = "The client ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "The object ID of the kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  sensitive   = true
}

output "identity_tenant_id" {
  description = "The tenant ID of the AKS identity"
  value       = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
  sensitive   = true
}

output "kv_secrets_provider_identity_client_id" {
  description = "The client ID of the Key Vault secrets provider identity"
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
  sensitive   = true
}