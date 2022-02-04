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
  description = "(Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
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
  description = "(Required) The name of the resource group in which to create the Microsoft SQL Server."
}

variable private_dns_resource_group_name {
  type        = string
  description = "(Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) The Azure region where the resources are created. Changing this forces a new resource to be created."
}

variable sql_version {
  type        = string
  description = "(Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
}

variable administrator_login {
  type        = string
  description = "(Required) The administrator login name for the new server. Changing this forces a new resource to be created."
}

variable administrator_login_password {
  type        = string
  description = "(Required) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy"
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for Private Endpoints. Changing this forces a new resource to be created."
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}
