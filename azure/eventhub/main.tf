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
resource "azurerm_eventhub" "this" {
  name                = lower(var.name)
  namespace_name      = var.namespace_name
  resource_group_name = var.resource_group_name
  partition_count     = var.partition_count
  message_retention   = var.message_retention
}

resource "azurerm_eventhub_authorization_rule" "this" {
  count               = length(var.auth_rules)

  name                = try(var.auth_rules[count.index].name, null)
  namespace_name      = var.namespace_name
  eventhub_name       = azurerm_eventhub.this.name
  resource_group_name = var.resource_group_name
  listen              = try(var.auth_rules[count.index].listen, false)
  send                = try(var.auth_rules[count.index].send, false)
  manage              = try(var.auth_rules[count.index].manage, false)
}