variable name {
  type        = string
  description = "(Required) Specifies the name of the Scheduled Trigger. Changing this forces a new resource to be created."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the resource group in which to create the Scheduled Trigger. Changing this forces a new resource."
}

variable data_factory_name {
  type        = string
  description = "(Required) The Data Factory name in which to associate the Scheduled Trigger with. Changing this forces a new resource."
}

variable pipeline_name {
  type        = string
  description = "(Required) The Data Factory Pipeline name that the trigger will act on."
}

variable interval {
  type        = number
  description = "(Optional) The interval for how often the trigger occurs. This defaults to 1."
}

variable frequency {
  type        = string
  description = "(Optional) The trigger freqency. Valid values include Minute, Hour, Day, Week, Month. Defaults to Minute."
}

variable start_time {
  type        = string
  description = "(Optional) The time the Schedule Trigger will start. This defaults to the current time. The time will be represented in UTC."
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}