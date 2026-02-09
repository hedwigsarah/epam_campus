resource "azurerm_traffic_manager_profile" "this" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.traffic_routing_method
  tags                   = var.tags

  dns_config {
    relative_name = var.name
    ttl           = 60
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = "/"
    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  for_each = var.endpoints

  name               = each.value.name
  profile_id         = azurerm_traffic_manager_profile.this.id
  target_resource_id = each.value.target_resource_id
  weight             = lookup(each.value, "weight", 1)
}