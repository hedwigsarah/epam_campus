# Azure Firewall Module - Main Configuration

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "firewall_subnet" {
  name                 = local.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.firewall_subnet_address_prefix]
}

resource "azurerm_public_ip" "firewall_pip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "firewall" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.firewall_sku_name
  sku_tier            = var.firewall_sku_tier
  tags                = local.common_tags

  ip_configuration {
    name                 = local.firewall_ip_config_name
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

resource "azurerm_route_table" "aks_route_table" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.common_tags

  route {
    name                   = local.default_route_name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.aks_route_table.id
}

resource "azurerm_firewall_application_rule_collection" "app_rules" {
  name                = local.app_rule_collection_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.app_rule_collection_priority
  action              = local.app_rule_collection_action

  rule {
    name             = "allow-aks-fqdns"
    source_addresses = ["*"]
    target_fqdns     = local.app_rule_fqdns

    protocol {
      port = "443"
      type = "Https"
    }

    protocol {
      port = "80"
      type = "Http"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "net_rules" {
  name                = local.net_rule_collection_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.net_rule_collection_priority
  action              = local.net_rule_collection_action

  rule {
    name                  = "allow-dns"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["53"]
    protocols             = ["UDP", "TCP"]
  }

  rule {
    name                  = "allow-ntp"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["123"]
    protocols             = ["UDP"]
  }

  rule {
    name                  = "allow-https"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["443"]
    protocols             = ["TCP"]
  }

  rule {
    name                  = "allow-tunnel-front"
    source_addresses      = ["*"]
    destination_addresses = ["AzureCloud"]
    destination_ports     = ["1194"]
    protocols             = ["UDP"]
  }

  rule {
    name                  = "allow-tunnel-front-tcp"
    source_addresses      = ["*"]
    destination_addresses = ["AzureCloud"]
    destination_ports     = ["9000"]
    protocols             = ["TCP"]
  }
}

resource "azurerm_firewall_nat_rule_collection" "nat_rules" {
  name                = local.nat_rule_collection_name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = local.nat_rule_collection_priority
  action              = "Dnat"

  rule {
    name                  = "nginx-dnat"
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
    destination_ports     = ["80"]
    protocols             = ["TCP"]
    translated_address    = var.aks_loadbalancer_ip
    translated_port       = "80"
  }
}