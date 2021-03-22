output "id" {
  value       = azurerm_servicebus_subscription.main.id
  description = "The ID of the ServiceBus Subscription."
}

output "name" {
  value       = azurerm_servicebus_subscription.main.name
  description = "The name of the ServiceBus Subscription."
}

output "dependent_on" {
  value = null_resource.dependency_setter.id
  description = "The dependencies of the ServiceBus Subscription."
}