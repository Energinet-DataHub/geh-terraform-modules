resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}
resource "null_resource" "dependency_setter" {
  depends_on = [azurerm_servicebus_subscription.main]
}

resource "azurerm_servicebus_subscription" "main" {
  depends_on          = [null_resource.dependency_getter]
  name                = var.name
  namespace_name      = var.namespace_name
  topic_name          = var.topic_name
  resource_group_name = var.resource_group_name
  max_delivery_count  = var.max_delivery_count
}