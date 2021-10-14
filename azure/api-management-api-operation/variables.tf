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
variable resource_group_name {
  type        = string
  description = "(Required) The Name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created."
}

variable operation_id {
  type        = string
  description = "(Required) A unique identifier for this API Operation. Changing this forces a new resource to be created."
}

variable api_management_api_name {
  type        = string
  description = "(Required) The name of the API within the API Management Service where this API Operation should be created. Changing this forces a new resource to be created."
}

variable api_management_name {
  type        = string
  description = "(Required) The Name of the API Management Service where the API exists. Changing this forces a new resource to be created."
}

variable display_name {
  type        = string
  description = "(Required) The Display Name for this API Management Operation."
}

variable method {
  type        = string
  description = "(Required) The HTTP Method used for this API Management Operation, like `GET`, `DELETE`, `PUT` or `POST` - but not limited to these values."
}

variable url_template {
  type        = string
  description = "(Required) The relative URL Template identifying the target resource for this operation, which may include parameters."
}

variable description {
  type        = string
  description = "(Optional) A description for this API Operation, which may include HTML formatting tags."
  default     = ""
}

variable policies {
  type        = list(object({
    xml_content = string
  }))
  description = "(Optional) A list of objects describing the policies for the API operation policies."
  default     = []
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}
