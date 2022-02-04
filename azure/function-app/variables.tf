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
  description = "(Required) Specifies the name of the Function App. Changing this forces a new resource to be created."
}

variable project_name {
  type          = string
  description   = "(Required) Name of the project this infrastructure is a part of."
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
  description = "(Required) The name of the resource group in which to create the Function App."
}

variable location {
  type        = string
  description = "(Required) The Azure region where the resources are created. Changing this forces a new resource to be created."
}

variable app_service_plan_id {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Function App."
}

variable application_insights_instrumentation_key {
  type        = string
  description = "(Required) The application insights instrumentation key for which data is to be logged into."
}

variable vnet_integration_subnet_id {
  type        = string
  description = "(Required) The id of the vnet integration subnet where this function will reside."
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for Private Endpoints. Changing this forces a new resource to be created."
}

variable private_dns_resource_group_name {
  type        = string
  description = "(Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."
}

variable app_settings {
  type        = map(string)
  description = "(Optional) A map of key-value pairs for App Settings and custom values."
  default     = {}
}

variable connection_strings {
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  description = "(Optional) A list of objects for App Settings Connection Strings."
  default     = []
}

variable always_on {
  type        = bool
  description = "(Optional) Should the Function App be loaded at all times? Defaults to false."
  default     = false
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}