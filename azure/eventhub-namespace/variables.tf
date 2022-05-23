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
terraform {
  experiments = [
    module_variable_optional_attrs,
  ]
}

variable name {
  type        = string
  description = "(Required) Specifies the name of the EventHub Namespace resource. Changing this forces a new resource to be created."
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
  description = "(Required) The name of the resource group in which the resources are created. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) The Azure region where the resources are created. Changing this forces a new resource to be created."
}

variable sku {
  type        = string
  description = "(Optional) Defines which tier to use. Valid options are Basic, Standard, and Premium. Please not that setting this field to Premium will force the creation of a new resource and also requires setting zone_redundant to true."
  default     = "Premium"
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for Private Endpoints. Changing this forces a new resource to be created."
}

variable capacity {
  type        = number
  description = "(Optional) Specifies the Capacity / Throughput Units for a Standard SKU namespace. Default capacity has a maximum of 20, but can be increased in blocks of 20 on a committed purchase basis."
}

variable log_analytics_workspace_id {
  type = string
  description = "(Required) The id of the Log Analytics Workspace where the Event Hub will log events (e.g. audit events) and metrics"
}

variable log_retention_in_days {
  type        = number
  description = "(Optional) The number of days for which this Retention Policy should apply."
  default     = 183
}

variable network_ruleset {
  type        = object({
    allowed_subnet_ids = list(string)
  })
  description = "(Required) The network ruleset of the EventHub namespace."
}


variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}