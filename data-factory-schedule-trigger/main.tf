resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
  command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_data_factory_trigger_schedule.main
  ]
}

resource "azurerm_data_factory_trigger_schedule" "main" {
  depends_on          = [null_resource.dependency_getter]
  name                = var.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  pipeline_name       = var.pipeline_name
  interval            = var.interval
  frequency           = var.frequency  
  start_time          = var.start_time
}
