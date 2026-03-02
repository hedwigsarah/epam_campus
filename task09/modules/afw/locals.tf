# Azure Firewall Module Locals

locals {
  # Azure Firewall subnet must be named "AzureFirewallSubnet"
  firewall_subnet_name = "AzureFirewallSubnet"

  # IP configuration name for Azure Firewall
  firewall_ip_config_name = "fw-ipconfig"

  # Default route name
  default_route_name = "default-route"

  # Common tags
  common_tags = var.tags
}
