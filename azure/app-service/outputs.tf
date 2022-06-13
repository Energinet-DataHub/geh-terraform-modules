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
output id {
  value       = azurerm_windows_web_app.this.id
  description = "The ID of the App Service."

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output name {
  value       = azurerm_windows_web_app.this.name
  description = "The name of the App Service."

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output default_hostname {
  value       = azurerm_windows_web_app.this.default_hostname
  description = "The default hostname associated with the App Service - such as mysite.azurewebsites.net"

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output outbound_ip_addresses {
  value       = azurerm_windows_web_app.this.outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12"

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output possible_outbound_ip_addresses {
  value       = azurerm_windows_web_app.this.possible_outbound_ip_addresses
  description = "A comma separated list of outbound IP addresses - such as 52.23.25.3,52.143.43.12,52.143.43.17 - not all of which are necessarily in use. Superset of outbound_ip_addresses"

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output identity {
  value       = azurerm_windows_web_app.this.identity
  description = "An identity block as defined below, which contains the Managed Service Identity information for this App Service."

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}

output site_credential {
  value       = azurerm_windows_web_app.this.site_credential
  description = "A site_credential block as defined below, which contains the site-level credentials used to publish to this App Service."

  depends_on  = [
    azurerm_windows_web_app.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_private_endpoint.this,
    azurerm_monitor_metric_alert.health_check_alert
  ]
}