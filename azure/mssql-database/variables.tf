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
  description   = "(Required) Name of the project this infrastructure is a part of."
}

variable environment_short {
  type        = string
  description = "(Required) The short value name of your environment."
}

variable environment_instance {
  type        = string
  description = "(Required) The instance value of your environment."
}

variable server_id {
  type        = string
  description = "(Required) The id of the MS SQL Server on which to create the database. Changing this forces a new resource to be created."
}

variable sku_name {
  type        = string
  default     = "GP_S_Gen5_1"
  description = "(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2, HS_Gen4_1, BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created."
}

variable min_capacity {
  type        = number
  default     = 1
  description = "(Optional) Minimal capacity of vCores that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases."
}

variable auto_pause_delay_in_minutes {
  type        = number
  default     = "-1"
  description = "(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases."
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
