# Azure Databricks Workspace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Databricks workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace)
- [Azure Virtual Network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
- [Azure Subnet-Network Security Group Association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
- [Azure Network Security Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "dbw_example" {
  source                                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/databricks-workspace?ref=6.0.0"

  name                                      = "example-name"
  project_name                              = "example-project-name"
  environment_short                         = "u"
  environment_instance                      = "001"
  resource_group_name                       = "example-resource-group-name"
  location                                  = "westeurope"
  sku                                       = "standard"
  main_virtual_network_id                   = "primary-vnet-id"
  main_virtual_network_name                 = "primary-vnet-name"
  main_virtual_network_resource_group_name  = "primary-vnet-resource-group-name"
  databricks_virtual_network_address_space  = "vnet-address-range"
  private_subnet_address_prefix             = "subnet-address-range"
  public_subnet_address_prefix              = "subnet-address-range"

  tags                                      = azurerm_resource_group.this.tags
}
```

Two tags are added by default

```ruby
locals {
  module_tags = {
    "ModuleId"      = "azure-databricks-workspace"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)