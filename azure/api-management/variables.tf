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
  description = "(Required) The name of the API Management Service. Changing this forces a new resource to be created."
}

variable project_name {
  type          = string
  description   = "(Required) The name of the project this infrastructure is a part of."
}

variable environment_short {
  type        = string
  description = "(Required) The short value name of the environment."
}

variable environment_instance {
  type        = string
  description = "(Required) The instance value of the environment."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which the resources are created. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) The Azure region where the resources are created. Changing this forces a new resource to be created."
}

variable publisher_name {
  type        = string
  description = "(Required) The name of publisher/company."
}

variable publisher_email {
  type        = string
  description = "(Required) The email of publisher/company."
}

variable sku_name {
  type        = string
  description = "(Required) A string consisting of two parts separated by an underscore(_). The first part is the name; valid values include: Consumption, Developer, Basic, Standard and Premium. The second part is the capacity (e.g. the number of deployed units of the sku), which must be a positive integer (e.g. Developer_1)."
}

variable virtual_network_type {
  type        = string
  description = "(Required) The type of virtual network to use for the API Management. Valid values include: Internal or External"
}

variable subnet_id {
  type        = string
  description = "(Required) The id of the subnet to use for the API Management."
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}