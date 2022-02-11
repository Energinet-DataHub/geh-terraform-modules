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
  description = "(Mandatory) Log workspace name"
}
variable "retention_in_days" {
  type        = number
  description = "(Optional) Log workspace rentention in days"
  default     = 30
}

variable "sku" {
  type        = string
  description = "(Optional) Log workspace sku"
  default     = "PerGB2018"
}
variable "project_name" {
  type        = string
  description = "(Required) Name of the project this infrastructure is a part of."
}

variable "environment_short" {
  type        = string
  description = "(Required) The short value name of the environment."
}

variable "environment_instance" {
  type        = string
  description = "(Required) The instance value of the environment."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resources."
}
variable "domain_name_short" {
  type = string
  description = "(Required) The short domain name"
}

variable "location" {
  type        = string
  description = "(Required) The Azure region where the resources are created. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

