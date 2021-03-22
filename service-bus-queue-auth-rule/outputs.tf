output "id" {
  value       = azurerm_servicebus_queue_authorization_rule.main.id
  description = "The ID of the ServiceBus Topic Authorization Rule."
}

output "name" {
  value       = azurerm_servicebus_queue_authorization_rule.main.name
  description = "The name of the ServiceBus Topic Authorization Rule."
}

output "dependent_on" {
  value = null_resource.dependency_setter.id
  description = "The dependencies of the ServiceBus Topic Authorization Rule."
}

output "primary_connection_string" {
  value       = azurerm_servicebus_queue_authorization_rule.main.primary_connection_string
  description = "The Primary Connection String for the ServiceBus Topic Authorization Rule."
}