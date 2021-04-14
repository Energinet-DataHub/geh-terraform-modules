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
  description = "(Required) Specifies the name of the ServiceBus Topic Authorization Rule resource. Changing this forces a new resource to be created."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which the ServiceBus Namespace exists. Changing this forces a new resource to be created."
}

variable namespace_name {
  type        = string
  description = "(Required) Specifies the name of the ServiceBus Namespace. Changing this forces a new resource to be created."
}

variable queue_name {
  type        = string
  description = "(Required) Specifies the name of the ServiceBus Topic. Changing this forces a new resource to be created."
}

variable listen {
  type        = bool
  description = "(Optional) Grants listen access to this this Authorization Rule. Defaults to false."
  default     = false
}

variable send {
  type        = bool
  description = "(Optional) Grants send access to this this Authorization Rule. Defaults to false."
  default     = false
}

variable manage {
  type        = bool
  description = "(Optional) Grants manage access to this this Authorization Rule. When this property is true - both listen and send must be too. Defaults to false."
  default     = false
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}
