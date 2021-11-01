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
variable name {
  type        = string
  description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}

variable project_name {
  type          = string
  description   = "Name of the project this infrastructure is a part of."
}

variable environment_short {
  type        = string
  description = "(Required) The short value name of your environment."
}

variable environment_instance {
  type        = string
  description = "(Required) The instance value of your environment."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable sku_name {
  type        = string
  description = "(Required) The Name of the SKU used for this Key Vault. Possible values are standard and premium."
}

variable access_policies {
  type        = list(object({
    tenant_id               = string
    object_id               = string
    secret_permissions      = list(string)
    key_permissions         = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "(Optional) A list of objects describing the Key Vault access policies."
  default     = []
}

variable enabled_for_template_deployment {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false."
  default     = false
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}