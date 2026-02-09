variable "name" {
  description = "The name of the Windows Web App"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Web App will be created"
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan"
  type        = string
}

variable "ip_restrictions" {
  description = "List of IP restrictions for the Web App"
  type = list(object({
    name        = string
    priority    = number
    action      = string
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to the Web App"
  type        = map(string)
  default     = {}
}