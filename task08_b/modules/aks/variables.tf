variable "name" {
  description = "The name of the Azure Kubernetes Service"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "default_node_pool_name" {
  description = "The name of the default node pool"
  type        = string
  default     = "system"
}

variable "default_node_pool_node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "default_node_pool_vm_size" {
  description = "The size of the Virtual Machine instances in the default node pool"
  type        = string
  default     = "Standard_D2ads_v6"
}

variable "default_node_pool_os_disk_type" {
  description = "The type of OS disk for the default node pool"
  type        = string
  default     = "Ephemeral"
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
