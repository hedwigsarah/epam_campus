resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile(var.secret_provider_template, {
    secret_provider_class = var.secret_provider_class
    identity_client_id    = var.identity_client_id
    keyvault_name         = var.keyvault_name
    redis_hostname_secret = var.redis_hostname_secret
    redis_password_secret = var.redis_password_secret
    tenant_id             = var.tenant_id
    secret_name           = var.k8s_secret_name
  })
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile(var.deployment_template, {
    app_name              = var.app_name
    image                 = var.image
    secret_name           = var.k8s_secret_name
    secret_provider_class = var.secret_provider_class
  })

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }

  depends_on = [kubectl_manifest.secret_provider]
}

resource "kubectl_manifest" "service" {
  yaml_body = file(var.service_manifest)

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }

  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name = "app-service"
  }

  depends_on = [kubectl_manifest.service]
}