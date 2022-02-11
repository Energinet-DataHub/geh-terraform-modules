


locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-log-workspace"
  }
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${var.name}-${lower(var.domain_name_short)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days  < 30  ? 30 : var.retention_in_days
  tags                = merge(var.tags, local.module_tags)
}

