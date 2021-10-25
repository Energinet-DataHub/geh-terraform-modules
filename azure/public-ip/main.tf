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

resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_public_ip.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0",
    "ModuleId"      = "azure-public-ip"
  }
}


resource "azurerm_public_ip" "this" {
  name                = "pip-${var.name}-${var.environment_short}-${var.environment_instance}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = merge(var.tags, local.module_tags)


  sku = var.sku 
  sku_tier = var.sku_tier
  allocation_method = var.allocation_method
  availability_zone = var.availability_zone
  ip_version = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label = var.domain_name_label
  reverse_fqdn = var.reverse_fqdn
  public_ip_prefix_id = var.public_ip_prefix_id
  ip_tags = var.tags


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}
