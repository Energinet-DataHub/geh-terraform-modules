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
  description = "(Required) Specifies the name of the Service Bus Topic resource. Changing this forces a new resource to be created."
}

variable namespace_id {
  type        = string
  description = "(Required) The ID of the ServiceBus Namespace to create this topic in. Changing this forces a new resource to be created."
}

variable requires_duplicate_detection {
  type        = bool
  description = "(Optional) Should the topic require duplicate detection? Defaults to false."
  default     = false
}

variable subscriptions {
  type    = list(object({
    name                = string
    max_delivery_count  = number
    forward_to          = optional(string)
  }))
  description = "(Optional) A list of objects describing the subscriptions of the Service Bus Topic."
  default = []
}

variable tags {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resources."
  default     = {}
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}