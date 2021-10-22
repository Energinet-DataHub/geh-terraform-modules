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

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the virtual network. Changing this forces a new resource to be created."
}

variable "environment_short" {
  type        = string
  description = "(Required) The short value name of your environment."
}

variable "environment_instance" {
  type        = string
  description = "(Required) The instance value of your environment."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the network. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "address_spaces" {
  type        = list(string)
  description = "(Required) List of the address spaces reserved by the virtual network."
}

variable "subnets" {
  type = list(object({
    name = string
    address_prefixes = list(string)
    security_group = string
  }))
  description = "(Required) List of Subnets creates in the virtual network."
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) List of the dns servers for the virtual network."
  default     = []
}

variable "ddos_protection_plan_id" {
  type        = string
  description = "(Optional) ID of a DDOS protection plan if this should be enabled on the network."
  default     = null
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}
