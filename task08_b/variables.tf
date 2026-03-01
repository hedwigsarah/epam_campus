variable "name_prefix" {
  description = "The prefix for all resource names"
  type        = string
  default     = "cmtr-7ymyr7zc-mod8b"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {}
}
