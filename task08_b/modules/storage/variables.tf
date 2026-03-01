variable "name" {
  description = "The name of the Storage Account"
  type        = string
}

variable "location" {
  description = "The Azure region where the Storage Account will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "account_replication_type" {
  description = "The type of replication to use for the Storage Account"
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
}

variable "container_access_type" {
  description = "The access type for the storage container"
  type        = string
  default     = "private"
}

variable "source_dir" {
  description = "The source directory to archive"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
