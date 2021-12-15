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

variable "allocation_method" {
  type        = string
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic"
}

variable "sku" {
  type        = string
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  default     = "Standard"
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for the Public IP. Possible values are Regional and Global"
  default     = "Regional"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone."
  default     = "Zone-Redundant"
}

variable "ip_version" {
  type        = string
  description = "The IP Version to use, IPv6 or IPv4"
  default     = "IPv4"
}

variable "idle_timeout_in_minutes" {
  type        = string
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  default     = "4"
}

variable "domain_name_label" {
  type        = string
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
}

variable "reverse_fqdn" {
  type        = string
  description = "A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN"
  default     = null
}

variable "public_ip_prefix_id" {
  type        = string
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource"
  default     = null
}
