# Azure Firewall Module - Main Configuration

# Data source to get existing virtual network
data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

# Azure Firewall Subnet
resource "azurerm_subnet" "firewall_subnet" {
  name                 = local.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.firewall_subnet_address_prefix]
}

# Public IP for Azure Firewall
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

# Azure Firewall
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

# Route Table
resource "azurerm_route_table" "aks_route_table" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
  tags                          = local.common_tags

  route {
    name                   = local.default_route_name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  }
}

# Route Table Association with AKS Subnet
resource "azurerm_subnet_route_table_association" "aks_subnet_association" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.aks_route_table.id
}

# Application Rule Collection
resource "azurerm_firewall_application_rule_collection" "app_rules" {
  for_each = { for rule in var.application_rules : rule.name => rule }

  name                = each.value.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns

      dynamic "protocol" {
        for_each = rule.value.protocol
        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

# Network Rule Collection
resource "azurerm_firewall_network_rule_collection" "net_rules" {
  for_each = { for rule in var.network_rules : rule.name => rule }

  name                = each.value.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = rule.value.destination_addresses
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

# NAT Rule Collection
resource "azurerm_firewall_nat_rule_collection" "nat_rules" {
  for_each = { for rule in var.nat_rules : rule.name => rule }

  name                = each.value.name
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = "Dnat"

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
    }
  }
}
