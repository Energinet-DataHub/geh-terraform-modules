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
  description = "(Required) The name which should be used for this Event Subscription. Changing this forces a new Event Subscription to be created."
}
variable resource_group_name {
  type        = string
  description = "(Required) The name of the Resource Group where the System Topic exists. Changing this forces a new Event Subscription to be created."
}

variable organisation_name {
  type        = string
  description = "(Required) Name of your organisation."
}

variable project_name {
  type        = string
  description = "(Required) Name of your project."
}

variable environment_short {
  type        = string
  description = "(Required) Specifies the environment short, of the environment."
}

variable system_topic {
  type        = string
  description = "(Required) The System Topic where the Event Subscription should be created in. Changing this forces a new Event Subscription to be created."
}

variable included_event_types {
  type        = list
  description = "(Optional) A list of applicable event types that need to be part of the event subscription."
  default     = []
}

variable storage_queue_endpoint {
  type        = any
  description = "(Optional) A storage_queue_endpoint with storage_account_id and name."
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}