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

variable "git_pat" {
  description = "Personal access token for the Git repository"
  type        = string
  sensitive   = true
}

variable "git_repo_url" {
  description = "URL of the Git repository with application source code"
  type        = string
  default     = "https://github.com/epam/epm-acct-prep-m8-task08#main:application"
}

variable "creator_tag" {
  description = "Creator tag value"
  type        = string
  default     = "sarah-hedwig_popescu@epam.com"
}