locals {
  rg_name       = "${var.name_prefix}-rg"
  aca_name      = "${var.name_prefix}-ca"
  aca_env_name  = "${var.name_prefix}-cae"
  acr_name      = "${replace(var.name_prefix, "-", "")}cr"
  aks_name      = "${var.name_prefix}-aks"
  keyvault_name = "${var.name_prefix}-kv"
  redis_aci_name = "${var.name_prefix}-redis-ci"
  sa_name       = replace("${var.name_prefix}sa", "-", "")
  
  image_name    = "${var.name_prefix}-app"
  
  common_tags   = var.tags
}
