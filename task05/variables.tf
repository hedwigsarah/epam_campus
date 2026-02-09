variable "resource_groups" {
  description = "Map of resource groups to create"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "app_service_plans" {
  description = "Map of App Service Plans to create"
  type = map(object({
    name               = string
    resource_group_key = string
    sku_name           = string
    worker_count       = number
  }))
}

variable "app_services" {
  description = "Map of App Services to create"
  type = map(object({
    name                 = string
    resource_group_key   = string
    app_service_plan_key = string
  }))
}

variable "traffic_manager_name" {
  description = "The name of the Traffic Manager profile"
  type        = string
}

variable "traffic_manager_resource_group_key" {
  description = "The key of the resource group for Traffic Manager"
  type        = string
}

variable "traffic_manager_routing_method" {
  description = "The traffic routing method for Traffic Manager"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "allowed_ip" {
  description = "IP address allowed to access the Web Apps"
  type        = string
}

variable "ip_rule_name" {
  description = "Name for the IP restriction rule"
  type        = string
}

variable "tm_rule_name" {
  description = "Name for the Traffic Manager service tag rule"
  type        = string
}