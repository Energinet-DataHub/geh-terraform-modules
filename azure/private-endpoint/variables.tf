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
  description = "(Required) The name of the private endpoint"
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
  description = "(Required) The name of the resource group in which to create the Microsoft SQL Server."
}

variable vnet_resource_group_name {
  type        = string
  description = "(Required) The name of the vnet resource group. This will be used to link the private endpoint to the private dns zone"
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The id of the subnet where the private endpoint will be created"
}

variable resource_id {
  type        = string
  description = "(Required) The ID of the resource that is getting a private endpoint "
}

variable resource_name {
  type        = string
  description = "(Required) The name of the resource that is getting a private endpoint "
}

variable resource_type {
  type        = string
  description = "(Required) The type of the resouce (fx. sqlServer) see: https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource "
}

variable zone_name {
  type        = string
  description = "(Required) The name of the private dns zone that the A-record will be applied to (fx. privatelink.database.windows.net) see: https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration "
}

