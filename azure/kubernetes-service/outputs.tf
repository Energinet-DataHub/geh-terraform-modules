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

output "id" {
  value       = azurerm_kubernetes_cluster.this.id
  description = "The ID of the Kubernetes cluster."
}

output "name" {
  value       = azurerm_kubernetes_cluster.this.name
  description = "The name of the Kubernetes cluster."
}

output "principal_id" {
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
  description = "The ID of the pricipal created for the cluster."
}

output "kube_admin_config" {
  description = "Outputs the kube_admin_config for the cluster."
  value       = azurerm_kubernetes_cluster.this.kube_admin_config 
  sensitive   = true
}
