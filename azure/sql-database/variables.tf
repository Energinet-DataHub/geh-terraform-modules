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
  description = "(Required) The name of the database."
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
  description = "(Required) The name of the resource group in which to create the database. This must be the same as Database Server resource group currently."
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable server_name {
  type        = string
  description = "(Required) The name of the SQL Server on which to create the database."
}



variable edition {
  type        = string
  default     = "GeneralPurpose"
  description = "The edition of the database to be created. Applies only if `create_mode` is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`."
}

variable requested_service_objective_name {
  type        = string
  default     = "GP_S_Gen5_1"
  description = "The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`."
}

variable log_analytics_workspace_id {
  type = string
  description = "(Required) The id of the Log Analytics Workspace where the SQL DB will log events (e.g. audit events)"
}


variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}
