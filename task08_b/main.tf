data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "keyvault" {
  source = "./modules/keyvault"

  name                = local.keyvault_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "standard"
  tags                = local.common_tags
}

module "storage" {
  source = "./modules/storage"

  name                     = local.sa_name
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_replication_type = "LRS"
  container_name           = "app-content"
  container_access_type    = "private"
  source_dir               = "${path.module}/application"
  tags                     = local.common_tags
}

module "aci_redis" {
  source = "./modules/aci_redis"

  name                       = local.redis_aci_name
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  sku                        = "Standard"
  key_vault_id               = module.keyvault.id
  key_vault_access_policy_id = module.keyvault.access_policy_id
  redis_password_secret_name = "redis-password"
  redis_hostname_secret_name = "redis-hostname"
  tags                       = local.common_tags

  depends_on = [module.keyvault]
}

module "acr" {
  source = "./modules/acr"

  name                 = local.acr_name
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  sku                  = "Basic"
  image_name           = local.image_name
  context_path         = module.storage.blob_url
  context_access_token = module.storage.sas_token
  tags                 = local.common_tags

  depends_on = [module.storage]
}

module "aks" {
  source = "./modules/aks"

  name                           = local.aks_name
  location                       = azurerm_resource_group.this.location
  resource_group_name            = azurerm_resource_group.this.name
  default_node_pool_name         = "system"
  default_node_pool_node_count   = 1
  default_node_pool_vm_size      = "Standard_D2ads_v6"
  default_node_pool_os_disk_type = "Ephemeral"
  acr_id                         = module.acr.id
  key_vault_id                   = module.keyvault.id
  tags                           = local.common_tags

  depends_on = [module.acr]
}

module "aca" {
  source = "./modules/aca"

  name                     = local.aca_name
  environment_name         = local.aca_env_name
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  key_vault_id             = module.keyvault.id
  acr_id                   = module.acr.id
  acr_login_server         = module.acr.login_server
  image                    = module.acr.image_name
  redis_hostname_secret_id = module.aci_redis.redis_hostname_secret_id
  redis_password_secret_id = module.aci_redis.redis_password_secret_id
  tags                     = local.common_tags

  depends_on = [module.acr, module.aci_redis]
}

module "k8s" {
  source = "./modules/k8s"

  deployment_template      = "${path.module}/k8s-manifests/deployment.yaml.tftpl"
  secret_provider_template = "${path.module}/k8s-manifests/secret-provider.yaml.tftpl"
  service_manifest         = "${path.module}/k8s-manifests/service.yaml"
  app_name                 = "app"
  image                    = module.acr.image_name
  secret_provider_class    = "azure-kv-secrets"
  identity_client_id       = module.aks.secret_provider_identity_client_id
  keyvault_name            = module.keyvault.name
  redis_hostname_secret    = "redis-hostname"
  redis_password_secret    = "redis-password"
  tenant_id                = data.azurerm_client_config.current.tenant_id
  k8s_secret_name          = "redis-secrets"

  depends_on = [module.aks, module.aci_redis]
}
