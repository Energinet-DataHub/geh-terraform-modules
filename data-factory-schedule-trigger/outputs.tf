output "id" {
  value       = azurerm_data_factory_trigger_schedule.main.id
  description = "The ID of the Scheduled Trigger."
}

output "name" {
  value       = azurerm_data_factory_trigger_schedule.main.name
  description = "The name of the Scheduled Trigger."
}

output "dependent_on" {
  value       = null_resource.dependency_setter.id
  description = "The dependencies of the Scheduled Trigger."
}
