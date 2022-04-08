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
  description = "(Required) The name of the API Management API. Changing this forces a new resource to be created."
}

variable project_name {
  type          = string
  description   = "The name of the project this infrastructure is a part of."
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
  description = "(Required) The name of the resource group where the API Management API exists. Changing this forces a new resource to be created."
}

variable api_management_name {
  type        = string
  description = "(Required) The Name of the API Management Service where this API should be created. Changing this forces a new resource to be created."
}

variable revision {
  type        = string
  description = "(Required) The revision which used for this API."
  default     = "1"
}

variable display_name {
  type        = string
  description = "(Optional) The display name of the API."
  default     = null
}

variable protocols {
  type        = list(string)
  description = "(Optional) A list of protocols the operations in this API can be invoked. Possible values are http and https."
  default     = ["https"]
}

variable subscription_required  {
  type        = bool
  description = "(Optional) Should this API require a subscription key"
  default     = false
}

variable policies {
  type        = list(object({
    xml_content = string
  }))
  description = "(Optional) A list of objects describing the policies for the API policies."
  default     = []
}

variable oauth2_authorization {
  type        = object({
    authorization_server_name   = string
  })
  description = "(Optional) OAuth authorization server identifier. The name of an OAuth2 Authorization Server."
  default     = null
}

variable apim_logger_id {
  type        = string
  description = "(Required) The ID of the Logger connected to API Management."
}

variable logger_sampling_percentage {
  type        = number
  description = "(Required) Sampling frequency (valid values are between 0.0 and 100.0) for how often to log request received by API Management. Regardless of the sampling frequency erroneous conditions are always logged."
}

variable path {
  type        = string
  description = "(Optional) The Path for this API Management API, which is a relative URL which uniquely identifies this API and all of its resource paths within the API Management Service."
  default     = null
}

variable backend_service_url {
  type        = string
  description = "(Optional) Absolute URL of the backend service implementing this API."
  default     = null
}

variable imports {
  type        = object({
    content_format  = string
    content_value   = string
  })
  description = ""
  default     = null
}