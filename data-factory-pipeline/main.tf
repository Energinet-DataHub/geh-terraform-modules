resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
  command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_data_factory_pipeline.main
  ]
}

resource "azurerm_data_factory_pipeline" "main" {
  depends_on          = [null_resource.dependency_getter]
  name                = var.name
  resource_group_name = var.resource_group_name
  data_factory_name   = var.data_factory_name
  activities_json     = var.activities_json
}
