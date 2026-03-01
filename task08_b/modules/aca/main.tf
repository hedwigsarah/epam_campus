data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "aca" {
  name                = "${var.name}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_access_policy" "aca" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.aca.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = azurerm_user_assigned_identity.aca.principal_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}

resource "azurerm_container_app_environment" "this" {
  name                = var.environment_name
  location            = var.location
  resource_group_name = var.resource_group_name

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }

  tags = var.tags
}

resource "azurerm_container_app" "this" {
  name                         = var.name
  container_app_environment_id = azurerm_container_app_environment.this.id
  resource_group_name          = var.resource_group_name
  revision_mode                = "Single"

  workload_profile_name = "Consumption"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.aca.id
  }

  secret {
    name                = "redis-url"
    key_vault_secret_id = var.redis_hostname_secret_id
    identity            = azurerm_user_assigned_identity.aca.id
  }

  secret {
    name                = "redis-key"
    key_vault_secret_id = var.redis_password_secret_id
    identity            = azurerm_user_assigned_identity.aca.id
  }

  template {
    container {
      name   = var.name
      image  = var.image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "CREATOR"
        value = "ACA"
      }

      env {
        name  = "REDIS_PORT"
        value = "6379"
      }

      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }

      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 5000
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_key_vault_access_policy.aca,
    azurerm_role_assignment.acr_pull
  ]
}
