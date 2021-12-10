# Public IP adress

- [Public IP adress](#public-ip-adress)
  - [Resources Created](#resources-created)
  - [Prerequisites](#prerequisites)
  - [Arguments and defaults](#arguments-and-defaults)
  - [Usage](#usage)
  - [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Public IP](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | (Required) Specifies the name of the virtual network. Changing this forces a new resource to be created. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `number` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `allocation_method` | `string` | | **Required** | Defines the allocation method for this IP address. Possible values are `Static` or `Dynamic` |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |
| `sku` | `string` | `Standard` | | The SKU of the Public IP. Accepted values are `Basic` and `Standard`. |
| `sku_tier` | `string` | `Regional` | | The SKU Tier that should be used for the Public IP. Possible values are `Regional` and `Global` |
| `availability_zone` | `string` | `Zone-Redundant` | | The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. |
| `ip_version` | `string` | `IPv4` | | The IP Version to use, `IPv6` or `IPv4` |
| `idle_timeout_in_minutes` | `string` | `4` | | Specifies the timeout for the TCP idle connection. The value can be set between `4` and `30` minutes. |
| `domain_name_label` | `string` | `null` | | Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. |
| `reverse_fqdn` | `string` | `null` | | A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN. |
| `public_ip_prefix_id` | `string` | `null` | | If specified then public IP address allocated will be provided from the public IP prefix resource. |
| `prevent_destroy` | `bool` | `False` | | If set to true, will prevent the IP from being deallocated by mistake. |


## Usage

```ruby

module "public_ip" {
  source = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/public-ip?ref=feature/aks"

  name                 = "Example name"
  environment_short    = "U"
  environment_instance = "001"
  resource_group_name  = "example-resource-group-name"
  location             = "westeurope"
  allocation_method    = "Static"
  domain_name_label    = "hello-world"
}

```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Kubernetes cluster. | |
| `name` | The name of the Kubernetes cluster. | |
| `ip_address` | The ipv4 address from the resource. | |
| `fqdn` | If domain_name_label specified, the resulting FQDN . | |
