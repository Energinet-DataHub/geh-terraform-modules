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
  description = "(Required) Specifies the name of the Databricks workspace resource. Changing this forces a new resource to be created."
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
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable sku {
  type        = string
  description = "(Required) The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. Changing this can force a new resource to be created in some circumstances."
}

variable main_virtual_network_id {
  type        = string
  description = "(Required) The ID of the primary Virtual network, which the Databricks VNet must be peered to."
}

variable main_virtual_network_name {
  type        = string
  description = "(Required) The name of the primary Virtual network"
}

variable main_virtual_network_resource_group_name {
  type        = string
  description = "(Required) The name resource group in which the primary Virtual network is deployed."
}

variable databricks_virtual_network_address_space {
  type        = string
  description = "(Required) The IP address space of the Virtual network, in which the Databricks clusters connected in the workspace, will be deployed."
}

variable private_subnet_address_prefix {
  type        = string
  description = "(Required) The IP address prefix of the private subnet that is deployed in the Virtual network for the Databricks clusters."
}

variable public_subnet_address_prefix {
  type        = string
  description = "(Required) The IP address prefix of the public subnet that is deployed in the Virtual network for the Databricks clusters."
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}