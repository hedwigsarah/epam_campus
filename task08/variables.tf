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


variable "creator_tag" {
  description = "Creator tag value"
  type        = string
  default     = "sarah-hedwig_popescu@epam.com"
}