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
  description = "(Required) The name of the Action Group. Changing this forces a new resource to be created."
}

variable project_name {
  type          = string
  description   = "(Required) The name of the project this infrastructure is a part of."
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
  description = "(Required) The name of the resource group in which to create the resource."
}

variable short_name {
  type        = string
  description = "(Required) The short name of the action group. This will be used if the email is relayed to SMS. Must be between 1 and 12 characters."
}

variable email_receiver_name {
  type        = string
  description = "(Required) The name of the email receiver."
}

variable email_receiver_address {
  type        = string
  description = "(Required) The email address of the email receiver."
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}
