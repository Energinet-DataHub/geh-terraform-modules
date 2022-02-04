# Azure Eventhub Namespace

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Eventhub Namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace)
- [Private Endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint)
- [Private DNS A Record](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

## Usage

```ruby
module "eventhub_namespace_example" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/eventhub-namespace?ref=6.0.0"

  name                            = "example-name"
  project_name                    = "example-project-name"
  environment_short               = "u"
  environment_instance            = "001"
  resource_group_name             = "example-resource-group-name"
  location                        = "westeurope"
  sku                             = "basic"
  private_endpoint_subnet_id      = "example-subnet-id"
  private_dns_resource_group_name = "example-resource-group-name-with-dns"
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-eventhub-namespace"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
