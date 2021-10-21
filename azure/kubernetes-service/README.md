# Azure Kubernetes Service

- [Azure Kubernetes Service](#azure-kubernetes-service)
  - [Resources Created](#resources-created)
  - [Prerequisites](#prerequisites)
  - [Arguments and defaults](#arguments-and-defaults)
  - [Usage](#usage)
  - [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure AKS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)

## Prerequisites

<!-- TODO: find prerequisites -->
- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+ <= 2.78.0
  - newer version has an error in a [github issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/11396)

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Kubernetes cluster. Changing this forces a new resource to be created.. The final name of the resource will follow this syntax `ks-{var.name}-{var.environment_short}-{var.environment_instance}` and be in lowercase. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `number` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `sku_tier` | `string` | | **Required** | The SKU used for this AKS cluster. Possible values are `Free` and `Paid`. `Paid` are recommended for production. |
| `vnet_subnet_id` | `string` | | **Required** | The ID of the subnet where the nodes will attach to. |
| `kubernetes_version` | `string` | | **Required** | The version of the Kubernetes cluster. Will be centrally updated unless specified. |
| `default_nodes` | `object` | `{`<br />&nbsp;&nbsp;&nbsp;&nbsp;`vm_size = "Standard_DS2_v3"`<br />&nbsp;&nbsp;&nbsp;&nbsp;`node_count = 1`<br />&nbsp;&nbsp;&nbsp;&nbsp;`min_count  = 1`<br />&nbsp;&nbsp;&nbsp;&nbsp;`max_count  = 3`<br />`}` | |  Configures the default nodes in the cluster. |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |

## Usage

```ruby
module "kubernetes_service_example" { 
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/kubernetes-service?ref=3.1.0"

  name                  = "example-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  sku_tier              = "Free"
  vnet_subnet_id        = "0000000-1111-2222-3333-444444444"
  kubernetes_version = "1.20.9"
  default_nodes       =  {
    vm_size    = "Standard_DS2_v3"
    node_count = 1
    min_count  = 1
    max_count  = 3
  }
}
```


## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Kubernetes cluster. | |
| `name` | The name of the Kubernetes cluster. | |
| `principal_id` | The ID of the pricipal created for the cluster. | |
| `kube_config` | Outputs the kube_config for the cluster. | True |
