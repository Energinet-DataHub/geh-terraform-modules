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
###
### REQUIRED VARIABLES
###
variable name {
  type        = string
  description = "(Required) Specifies the name of the Function App. Changing this forces a new resource to be created."

  validation {
    condition     = can(regex("^[\\w]{1}[\\-\\w]{2,61}[\\w]{1}$", var.name))
    error_message = "The value must consist of alphanumerics and hyphens. Must start and end with alphanumeric."
  }
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

variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which to create the Function App."
}

variable location {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable app_service_plan_id {
  type        = string
  description = "(Required) The ID of the App Service Plan within which to create this Function App." 
}

variable application_insights_instrumentation_key {
  type        = string
  description = "The application insights instrumentation key for which data is to be logged into"
}

variable application_insights_id {
  type        = string
  description = "The application insights instrumentation id for which data is to be logged into"
}

variable metric_alert_action_group_id {
  type        = string
  description = "(Required) ID of the action group to trigger when an alert is raised"
}

###
### OPTIONAL VARIABLES
###
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

variable function_app_settings {
  type        = map(string)
  description = "(Optional) A map of key-value pairs for App Settings and custom values." 
  default     = {}
}

variable function_connection_string {
  type        = map(string)
  description = "(Optional) An connection_string block as defined below."
  default     = {}
}

variable function_always_on {
  type        = bool
  description = "(Optional) Should the Function App be loaded at all times? Defaults to false"
  default     = false
}

variable web_test_frequency {
  type        = number
  description = "(Optional) Interval in seconds between test runs for this WebTest. Valid options are 300, 600 and 900. Defaults to 300."
  default     = 300
}

variable web_test_timeout {
  type        = number
  description = "(Optional) Seconds until this WebTest will timeout and fail. Default is 60."
  default     = 60
}

variable web_test_enabled {
  type        = bool
  description = "(Optional) Is the test actively being monitored."
  default     = true
}

variable web_test_retry_enabled {
  type        = bool
  description = "(Optional) Whether to retry the availability test 3 times before failing it"
  default     = true   
}

variable web_test_geo_locations {
  type        = list
  description = "(Optional) A list of where to physically run the tests from to give global coverage for accessibility of your application."
  // See https://docs.microsoft.com/en-us/azure/azure-monitor/app/monitor-web-app-availability
  default     = ["emea-au-syd-edge", "latam-br-gru-edge", "us-tx-sn1-azr", "apac-hk-hkn-azr", "emea-nl-ams-azr"]
}

variable metric_alert_threshold {
  type        = number
  description = "(Optional) The number of times the availability test needs to fail before issuing an alert"
  default     = 3
}

variable metric_alert_frequency {
  type        = string
  description = "(Optional) How often this availability is monitored, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H."
  default     = "PT5M"
}

variable metric_alert_window_size {
  type        = string
  description = "(Optional) Time window to consider when monitoring for the threshold. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D."
  default     = "PT30M"
}

variable metric_alert_description {
  type        = string
  description = "(Optional) Description shown for the alert rules"
  default     = "Action will be triggered when ping test has failed more than x times within the specified frequency"
}

locals {
  validate_total_name_length = (length(var.project_name) + length(var.organisation_name) + length(var.name)) > 20 ? "The combined length of name, project_name and organisation_name cannot be more than 20 characters." : ""
}