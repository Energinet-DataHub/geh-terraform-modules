# Azure Private endpoint and A-record entry

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)

## Resources Created

This module creates the following resources.

- [Azure Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [A Records within Azure Private DNS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the private endpoint. The final name of the resource will follow this syntax `pe-{var.name}-${var.environment_short}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Function App. |
| `vnet_resource_group_name` | `string` | | **Required** | The name of the vnet resource group. This will be used to link the private endpoint to the private dns zone |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `private_endpoint_subnet_id` | `string` | |  **Required**|  The ID of the private endpoint subnet |
| `resource_id` | `string` | | **Required**|  The ID of the resource that is getting a private endpoint |
| `resource_name` | `string` | | **Required**|  The name of the resource that is getting a private endpoint |
| `resource_type` | `string` | | **Required**|  The type of the resouce (fx. sqlServer) see: [https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource) |
| `zone_name` | `string` |  | **Required**| The name of the private dns zone that the A-record will be applied to (fx. privatelink.database.windows.net) see: [https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration](https://docs.microsoft.com/en-us/azure/private-link/private-endpoint-dns#azure-services-dns-zone-configuration) |

## Usage

```ruby
module "private_endpoint_example" { 
  source                        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/private-endpoint?ref=6.0.0"

  name                          = "example-name"
  project_name                  = "example-project-name"
  environment_short             = "p"
  environment_instance          = "001"
  resource_group_name           = "example-resource-group-name"
  vnet_resource_group_name      = "example-vnet-resource-group-name"
  location                      = "westeurope"
  private_endpoint_subnet_id    = "pe-subnet"
  resource_id                   = azurerm_mssql_server.this.id
  resource_name                 = azurerm_mssql_server.this.name
  resource_type                 = "sqlServer"
  zone_name                     = "privatelink.database.windows.net"
}
