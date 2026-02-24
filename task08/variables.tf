variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cmtr-7ymyr7zc-mod8"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "context_access_token" {
  description = "Personal access token for the Git repository"
  type        = string
  sensitive   = true
  default     = ""
}

variable "context_path" {
  description = "URL of the Git repository with application source code"
  type        = string
  default     = ""
}


variable "creator_tag" {
  description = "Creator tag value"
  type        = string
  default     = "sarah-hedwig_popescu@epam.com"
}