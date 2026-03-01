variable "deployment_template" {
  description = "Path to the Kubernetes deployment template"
  type        = string
}

variable "secret_provider_template" {
  description = "Path to the Kubernetes secret provider template"
  type        = string
}

variable "service_manifest" {
  description = "Path to the Kubernetes service manifest"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
  default     = "app"
}

variable "image" {
  description = "The Docker image to deploy"
  type        = string
}

variable "secret_provider_class" {
  description = "The name of the secret provider class"
  type        = string
  default     = "azure-kv-secrets"
}

variable "identity_client_id" {
  description = "The client ID of the managed identity"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "redis_hostname_secret" {
  description = "The name of the Redis hostname secret"
  type        = string
  default     = "redis-hostname"
}

variable "redis_password_secret" {
  description = "The name of the Redis password secret"
  type        = string
  default     = "redis-password"
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

variable "k8s_secret_name" {
  description = "The name of the Kubernetes secret"
  type        = string
  default     = "redis-secrets"
}
