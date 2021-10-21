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
  description = "(Required) Specifies the name of the Kubernetes cluster. Changing this forces a new resource to be created."
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
  description = "(Required) The name of the resource group in which to create the AKS cluster. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku_tier" {
  type        = string
  description = "(Required) The SKU used for this AKS cluster. Possible values are Free and Paid. Paid are recommended for production."
}

variable "vnet_subnet_id" {
  type        = string
  description = "(Required) The ID of the subnet where the nodes will attach to."
}

variable "kubernetes_version" {
  type        = string
  description = "The version of the Kubernetes cluster. Will be centrally updated unless specified."
  default     = "1.20.9"
}

variable "default_nodes" {
  type = object({
    vm_size    = string
    node_count = number
    min_count  = number
    max_count  = number
  })
  description = "Configures the default nodes in the cluster."
  default = {
    vm_size    = "Standard_DS2_v3"
    node_count = 1
    min_count  = 1
    max_count  = 3
  }
}

variable "tags" {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
