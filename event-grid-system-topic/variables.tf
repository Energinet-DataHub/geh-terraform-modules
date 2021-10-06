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
  description = "(Required) The name which should be used for this Event Grid System Topic. Changing this forces a new Event Grid System Topic to be created."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the Resource Group where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created."
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

variable location {
  type        = string
  description = "(Required) The Azure Region where the Event Grid System Topic should exist. Changing this forces a new Event Grid System Topic to be created."
}

variable source_arm_resource_id {
  type        = string
  description = "(Required) The ID of the Event Grid System Topic ARM Source. Changing this forces a new Event Grid System Topic to be created."
}

variable topic_type {
  type        = string
  description = "(Required) The Topic Type of the Event Grid System Topic. Possible values are: Microsoft.AppConfiguration.ConfigurationStores, Microsoft.Communication.CommunicationServices , Microsoft.ContainerRegistry.Registries, Microsoft.Devices.IoTHubs, Microsoft.EventGrid.Domains, Microsoft.EventGrid.Topics, Microsoft.Eventhub.Namespaces, Microsoft.KeyVault.vaults, Microsoft.MachineLearningServices.Workspaces, Microsoft.Maps.Accounts, Microsoft.Media.MediaServices, Microsoft.Resources.ResourceGroups, Microsoft.Resources.Subscriptions, Microsoft.ServiceBus.Namespaces, Microsoft.SignalRService.SignalR, Microsoft.Storage.StorageAccounts, Microsoft.Web.ServerFarms and Microsoft.Web.Sites. Changing this forces a new Event Grid System Topic to be created."
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