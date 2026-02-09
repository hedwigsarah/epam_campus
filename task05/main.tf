module "resource_group" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

module "app_service_plan" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = module.resource_group[each.value.resource_group_key].location
  sku_name            = each.value.sku_name
  worker_count        = each.value.worker_count
  tags                = var.tags
}

module "app_service" {
  source   = "./modules/app_service"
  for_each = var.app_services

  name                = each.value.name
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = module.resource_group[each.value.resource_group_key].location
  service_plan_id     = module.app_service_plan[each.value.app_service_plan_key].id
  tags                = var.tags

  ip_restrictions = [
    {
      name       = var.ip_rule_name
      priority   = 100
      action     = "Allow"
      ip_address = "${var.allowed_ip}/32"
    },
    {
      name        = var.tm_rule_name
      priority    = 200
      action      = "Allow"
      service_tag = "AzureTrafficManager"
    }
  ]
}

module "traffic_manager" {
  source = "./modules/traffic_manager"

  name                   = var.traffic_manager_name
  resource_group_name    = module.resource_group[var.traffic_manager_resource_group_key].name
  traffic_routing_method = var.traffic_manager_routing_method
  tags                   = var.tags

  endpoints = {
    for key, app in var.app_services : key => {
      name               = module.app_service[key].name
      target_resource_id = module.app_service[key].id
    }
  }
}