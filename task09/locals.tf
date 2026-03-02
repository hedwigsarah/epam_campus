# Root Module Locals

locals {
  firewall_name    = "${var.naming_prefix}-afw"
  route_table_name = "${var.naming_prefix}-rt"

  firewall_subnet_address_prefix = "10.0.1.0/26"

  common_tags = merge(
    var.tags,
    {
      environment = "development"
      managed_by  = "terraform"
    }
  )

  # Rule collection names using naming prefix
  app_rule_collection_name = "${var.naming_prefix}-app-rules"
  net_rule_collection_name = "${var.naming_prefix}-net-rules"
  nat_rule_collection_name = "${var.naming_prefix}-nat-rules"

  # Application rules for AKS egress
  application_rules = [
    {
      name     = local.app_rule_collection_name
      priority = 100
      action   = "Allow"
      rules = [
        {
          name             = "allow-aks-fqdns"
          source_addresses = ["*"]
          target_fqdns = [
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
          protocol = [
            {
              port = "443"
              type = "Https"
            },
            {
              port = "80"
              type = "Http"
            }
          ]
        }
      ]
    }
  ]

  # Network rules for AKS
  network_rules = [
    {
      name     = local.net_rule_collection_name
      priority = 100
      action   = "Allow"
      rules = [
        {
          name                  = "allow-dns"
          source_addresses      = ["*"]
          destination_addresses = ["*"]
          destination_ports     = ["53"]
          protocols             = ["UDP", "TCP"]
        },
        {
          name                  = "allow-ntp"
          source_addresses      = ["*"]
          destination_addresses = ["*"]
          destination_ports     = ["123"]
          protocols             = ["UDP"]
        },
        {
          name                  = "allow-https"
          source_addresses      = ["*"]
          destination_addresses = ["*"]
          destination_ports     = ["443"]
          protocols             = ["TCP"]
        },
        {
          name                  = "allow-tunnel-front"
          source_addresses      = ["*"]
          destination_addresses = ["AzureCloud"]
          destination_ports     = ["1194"]
          protocols             = ["UDP"]
        },
        {
          name                  = "allow-tunnel-front-tcp"
          source_addresses      = ["*"]
          destination_addresses = ["AzureCloud"]
          destination_ports     = ["9000"]
          protocols             = ["TCP"]
        }
      ]
    }
  ]

  # NAT rules for inbound traffic to NGINX
  nat_rules = [
    {
      name     = local.nat_rule_collection_name
      priority = 100
      rules = [
        {
          name               = "nginx-dnat"
          source_addresses   = ["*"]
          destination_ports  = ["80"]
          protocols          = ["TCP"]
          translated_address = var.aks_loadbalancer_ip
          translated_port    = "80"
        }
      ]
    }
  ]
}