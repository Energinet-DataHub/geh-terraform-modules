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
  description = "(Required) Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
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
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

variable private_dns_resource_group_name {
  type        = string
  description = "(Required) Specifies the resource group where the Private DNS Zone exists. Changing this forces a new resource to be created."
}

variable private_endpoint_subnet_id {
  type        = string
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable account_tier {
  type        = string
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable account_replication_type {
  type        = string
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}

variable access_tier {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  default     = "Hot"
}

variable is_hns_enabled {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information - https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/). Changing this forces a new resource to be created."
  default     = false
}

variable account_kind {
  type        = string
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Changing this forces a new resource to be created. Defaults to StorageV2."
  default     = "StorageV2"
}

variable containers {
  type        = list(object({
    name        = string
    access_type = optional(string)
  }))
  description = "(Optional) A list of objects describing the containers, to create in the Storage Account."
  default     = []
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}