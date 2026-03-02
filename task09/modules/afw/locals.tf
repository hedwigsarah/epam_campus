# Azure Firewall Module Locals

locals {
  firewall_subnet_name    = "AzureFirewallSubnet"
  firewall_ip_config_name = "fw-ipconfig"
  default_route_name      = "default-route"
  common_tags             = var.tags

  # Application rules for AKS egress
  app_rule_collection_name     = "aks-app-rules"
  app_rule_collection_priority = 100
  app_rule_collection_action   = "Allow"

  app_rule_fqdns = [
    "*.hcp.eastus.azmk8s.io",
    "mcr.microsoft.com",
    "*.data.mcr.microsoft.com",
    "management.azure.com",
    "login.microsoftonline.com",
    "packages.microsoft.com",
    "acs-mirror.azureedge.net",
    "*.ubuntu.com",
    "*.docker.io",
    "*.docker.com",
    "production.cloudflare.docker.com",
    "*.azurecr.io",
    "*.blob.core.windows.net",
    "*.trafficmanager.net",
    "*.opinsights.azure.com",
    "*.monitoring.azure.com",
    "dc.services.visualstudio.com"
  ]

  # Network rules for AKS
  net_rule_collection_name     = "aks-network-rules"
  net_rule_collection_priority = 100
  net_rule_collection_action   = "Allow"

  # NAT rules for inbound traffic to NGINX
  nat_rule_collection_name     = "aks-nat-rules"
  nat_rule_collection_priority = 100
}