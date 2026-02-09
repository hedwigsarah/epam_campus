resource "azurerm_windows_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id
  tags                = var.tags

  site_config {
    ip_restriction_default_action = "Deny"

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions
      content {
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        action      = ip_restriction.value.action
        ip_address  = lookup(ip_restriction.value, "ip_address", null)
        service_tag = lookup(ip_restriction.value, "service_tag", null)
      }
    }
    scm_use_main_ip_restriction = true
  }
}