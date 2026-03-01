resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "build" {
  name                  = "${var.image_name}-build"
  container_registry_id = azurerm_container_registry.this.id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.context_path
    context_access_token = var.context_access_token
    image_names          = ["${var.image_name}:latest"]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "build" {
  container_registry_task_id = azurerm_container_registry_task.build.id
}
