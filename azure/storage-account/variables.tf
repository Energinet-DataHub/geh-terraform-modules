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

variable use_blob {
  type        = bool
  description = "(Optional) Determine if the blob subresource of the storage account should be configured for usage. Defaults to 'true'."
  default     = true
}

variable use_file {
  type        = bool
  description = "(Optional) Determine if the file subresource of the storage account should be configured for usage. Defaults to 'false'."
  default     = false
}

variable use_dfs {
  type        = bool
  description = "(Optional) Determine if the Data Lake File System Gen2 subresource of the storage account should be configured for usage. Defaults to 'false'."
  default     = false
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

variable log_analytics_workspace_id {
  type = string
  description = "(Required) The id of the Log Analytics Workspace where the Storage Account will log events (e.g. audit events)"
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