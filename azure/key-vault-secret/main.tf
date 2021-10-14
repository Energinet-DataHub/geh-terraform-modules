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
    azurerm_key_vault_secret.this,
  ]
}

locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "key-vault-secret"
  }
}

resource "azurerm_key_vault_secret" "this" {
  name          = var.name
  value         = var.value
  key_vault_id  = var.key_vault_id

  tags          = merge(var.tags, local.module_tags)

  depends_on    = [
    null_resource.dependency_getter,
  ]

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}