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
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
  command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [
    azurerm_data_factory_dataset_delimited_text.main
  ]
}

resource "azurerm_data_factory_dataset_delimited_text" "main" {
  depends_on                  = [null_resource.dependency_getter]
  name                        = var.name
  resource_group_name         = var.resource_group_name
  data_factory_name           = var.data_factory_name
  linked_service_name         = var.linked_service_name

  azure_blob_storage_location {
    container = var.azure_blob_storage_location.container
    path      = var.azure_blob_storage_location.path
    filename  = var.azure_blob_storage_location.filename
  }

  column_delimiter            = var.column_delimiter
  row_delimiter               = var.row_delimiter
  encoding                    = var.encoding
  quote_character             = var.quote_character
  escape_character            = var.escape_character
  first_row_as_header         = var.first_row_as_header
  null_value                  = var.null_value
}
