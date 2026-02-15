resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location

  tags = local.common_tags
}

# Key Vault Module
module "keyvault" {
  source = "./modules/keyvault"

  keyvault_name       = local.keyvault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tags                = local.common_tags
}

# Redis Module
module "redis" {
  source = "./modules/redis"

  redis_name                    = local.redis_name
  location                      = azurerm_resource_group.rg.location
  resource_group_name           = azurerm_resource_group.rg.name
  capacity                      = 2
  family                        = "C"
  sku_name                      = "Basic"
  key_vault_id                  = module.keyvault.key_vault_id
  redis_hostname_secret_name    = local.redis_hostname_secret_name
  redis_primary_key_secret_name = local.redis_primary_key_secret_name
  tags                          = local.common_tags

  depends_on = [module.keyvault]
}

# ACR Module
module "acr" {
  source = "./modules/acr"

  acr_name             = local.acr_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  sku                  = "Basic"
  image_name           = local.image_name
  context_path         = var.git_repo_url
  context_access_token = var.git_pat
  tags                 = local.common_tags
}

# AKS Module
module "aks" {
  source = "./modules/aks"

  aks_name            = local.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  node_pool_name      = "system"
  node_count          = 1
  node_size           = "Standard_D2ads_v6"
  os_disk_type        = "Ephemeral"
  acr_id              = module.acr.acr_id
  key_vault_id        = module.keyvault.key_vault_id
  tags                = local.common_tags

  depends_on = [module.acr, module.keyvault]
}

# ACI Module
module "aci" {
  source = "./modules/aci"

  aci_name            = local.aci_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  acr_login_server    = module.acr.acr_login_server
  acr_admin_username  = module.acr.acr_admin_username
  acr_admin_password  = module.acr.acr_admin_password
  image_name          = local.image_name
  redis_hostname      = module.redis.redis_hostname
  redis_primary_key   = module.redis.redis_primary_access_key
  tags                = local.common_tags

  depends_on = [module.acr, module.redis]
}

# Kubernetes Manifests
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.kv_secrets_provider_identity_client_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = local.redis_hostname_secret_name
    redis_password_secret_name = local.redis_primary_key_secret_name
    tenant_id                  = module.keyvault.tenant_id
  })

  depends_on = [module.aks]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider, module.aci]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

# Data source for Kubernetes service to get LoadBalancer IP
data "kubernetes_service" "app" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}