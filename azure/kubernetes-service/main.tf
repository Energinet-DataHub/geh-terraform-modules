# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0",
    "ModuleId"      = "azure-kubernetes-service"
  }
}

resource "azurerm_kubernetes_cluster" "this" {
  name                            = "ks-${var.name}-${var.environment_short}-${var.environment_instance}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  node_resource_group             = "${var.resource_group_name}-nodes"
  dns_prefix                      = "${var.name}-${var.environment_short}-${var.environment_instance}"
  tags                            = merge(var.tags, local.module_tags)
  kubernetes_version              = var.kubernetes_version
  api_server_authorized_ip_ranges = []
  private_cluster_enabled         = false

  identity {
    type                      = var.identity_type
    user_assigned_identity_id = var.identity_type == "UserAssigned" ? var.identity_id : null
  }

  sku_tier = var.sku_tier

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

  addon_profile {
      azure_policy {
      enabled = var.azure_policy_enabled
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    outbound_type     = "loadBalancer"
    load_balancer_sku = "Standard"
    load_balancer_profile {
      outbound_ip_address_ids = var.outbound_ip_address_ids
    }
  }

  default_node_pool {
    orchestrator_version = var.kubernetes_version

    vnet_subnet_id = var.vnet_subnet_id

    name                = "default"
    availability_zones  = [1, 2, 3]
    vm_size             = var.default_nodes.vm_size
    enable_auto_scaling = true
    os_disk_type        = "Ephemeral"
    node_count          = var.default_nodes.min_count
    min_count           = var.default_nodes.min_count
    max_count           = var.default_nodes.max_count
    node_taints         = []
    tags                = {}

    enable_host_encryption       = false
    enable_node_public_ip        = false
    only_critical_addons_enabled = false
    upgrade_settings {
      max_surge = 1
    }
  }

  lifecycle {
    ignore_changes = [
      # Ignore node_count as not to update if the value is changed by Azure.
      default_node_pool[0].node_count,
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
