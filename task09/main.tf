# Root Module - Main Configuration

# Data source to get the existing AKS subnet
data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# Azure Firewall Module
module "afw" {
  source = "./modules/afw"

  resource_group_name            = var.resource_group_name
  location                       = var.location
  virtual_network_name           = var.virtual_network_name
  firewall_subnet_address_prefix = local.firewall_subnet_address_prefix
  firewall_name                  = local.firewall_name
  firewall_sku_name              = "AZFW_VNet"
  firewall_sku_tier              = "Standard"
  public_ip_name                 = var.firewall_public_ip_name
  route_table_name               = local.route_table_name
  aks_subnet_id                  = data.azurerm_subnet.aks_subnet.id
  aks_loadbalancer_ip            = var.aks_loadbalancer_ip
  tags                           = local.common_tags
  application_rules              = local.application_rules
  network_rules                  = local.network_rules
  nat_rules                      = local.nat_rules
}