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
  description = "(Required) Specifies the name of the Service Bus Namespace resource . Changing this forces a new resource to be created."
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

variable auth_rules {
  type        = list(object({
    name    = string
    listen  = optional(bool)
    send    = optional(bool)
    manage  = optional(bool)
  }))
  description = "(Required) A list of objects describing the Service Bus Namespace auth rules."
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for Private Endpoints. Changing this forces a new resource to be created."
}

variable private_dns_resource_group_name {
  type        = string
  description = "(Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."
}

variable capacity {
  type        = number
  description = "(Optional) The capcity when using premium sku."
  default     = 1
  validation {
    condition     = contains([1,2,4,8,16], var.capacity)
    error_message = "Valid values for var: capacity are (1,2,4,8,16)."
  }
}
  
variable log_analytics_workspace_id {
  type = string
  description = "(Optional) The id of the Log Analytics Workspace where theService Bus will log events (e.g. audit events)"
  default = null
}

variable log_retention_in_days {
  type        = number
  description = "(Optional) The number of days for which this Retention Policy should apply."
  default     = 183
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}
