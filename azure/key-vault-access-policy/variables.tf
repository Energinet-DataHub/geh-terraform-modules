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
variable key_vault_id {
  type        = string
  description = "(Required) Specifies the ID of the Key Vault resource. Changing this forces a new resource to be created."
}

variable app_identity {
  type        = object({
    principal_id  = string
    tenant_id     = string
  })
  description = "(Required) The object ID of the app in the Azure Active Directory tenant for the vault. The principal (object) ID must be unique for the list of access policies. Changing this forces a new resource to be created."
}