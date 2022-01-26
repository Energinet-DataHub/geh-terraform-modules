# Azure Subnet

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Virtual Network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the virtual network. Changing this forces a new resource to be created. `vnet-${var.name}-${var.project_name}-${var.environment_short}-${var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the Resource Group in which the Subnet should be exist. Changing this forces a new resource to be created. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `address_space` | `list(string)` | | **Required** | The address space that is used the virtual network. You can supply more than one address space. |
| `peerings` | `list()` | `[]` | |  A list of objects describing the virtual network peerings. See [Peering](#peering). |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |

### Peering

An `peering` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the virtual network peering. Changing this forces a new resource to be created. The final name will be in lowercase |
| `remote_virtual_network_id` | `string` | | **Required** | The full Azure resource ID of the remote virtual network. Changing this forces a new resource to be created. |
| `remote_resource_group_name` | `string` | | **Required** | The Azure resource resource group name of the remote virtual networks location. Changing this forces a new resource to be created. |

## Usage

```ruby
module "vnet_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/vnet?ref=6.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  location              = "example-location"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  address_space         = ["10.0.0.0/16"]
  peerings              = [
    {
      name                      = "example-peering"
      remote_virtual_network_id = "example-remote-virtual-network-id"
    }
  ]
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-subnet"
  }
}
```
