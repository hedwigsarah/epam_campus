variable "name" {
  description = "The name of the Traffic Manager profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "traffic_routing_method" {
  description = "The traffic routing method for the Traffic Manager profile"
  type        = string
}

variable "endpoints" {
  description = "Map of endpoints to create"
  type = map(object({
    name               = string
    target_resource_id = string
    weight             = optional(number, 1)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the Traffic Manager profile"
  type        = map(string)
  default     = {}
}