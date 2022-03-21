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
    "ModuleVersion" = "5.8.0"
    "ModuleId"      = "monitor-action-group-email"
  }
}

resource "azurerm_monitor_action_group" "this" {
  name                      = "ag-${lower(var.name)}-${lower(var.project_name)}-${lower(var.environment_short)}-${lower(var.environment_instance)}"
  resource_group_name       = var.resource_group_name
  short_name                = var.short_name

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_receiver_address
    use_common_alert_schema = true
  }

  tags                      = merge(var.tags, local.module_tags)

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}