variable name {
  type        = string
  description = "(Required) Specifies the name of the ServiceBus Subscription resource. Changing this forces a new resource to be created."
}

variable resource_group_name {
  type        = string
  description = "(Required) The name of the ServiceBus Namespace to create this Subscription in. Changing this forces a new resource to be created."
}

variable namespace_name {
  type        = string
  description = "(Required) The name of the ServiceBus Namespace to create this Subscription in. Changing this forces a new resource to be created."
}

variable topic_name {
  type        = string
  description = "(Required) The name of the ServiceBus Topic to create this Subscription in. Changing this forces a new resource to be created."
}

variable max_delivery_count {
  type        = string
  description = "(Required) The maximum number of deliveries."
}

variable dependencies {
  type        = list
  description = "A mapping of dependencies which this module depends on."
  default     = []
}
