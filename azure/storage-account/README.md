# Azure Storage Account

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Storage Account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account)

## Prerequisites

- Terraform version 1.0.6+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Description |
|-|-|-|-|
| `name` | `string` | | **Required** Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group. The final name of the resource will follow this syntax `st{var.name}{var.environment_short}` and be in lowercase. |
| `environment_short` | `string` | | **Required** The short value name of your environment. |
| `environment_instance` | `string` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. |
| `location` | `string` | | **Required** Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `account_tier` | `string` | | **Required** Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For BlockBlobStorage and FileStorage accounts only `Premium` is valid. Changing this forces a new resource to be created. |
| `account_replication_type` | `string` | | **Required** Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. |
| `access_tier` | `string` | `"Hot"` | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`. |
| `is_hns_enabled` | `string` | `false` | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 ([see here for more information](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/)). Changing this forces a new resource to be created. |
| `account_kind` | `string` | `"StorageV2"` | Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Changing this forces a new resource to be created. Defaults to `StorageV2`. |
| `containers` | `list` | `[]` | A list of objects describing the containers, to create in the Storage Account. [Container](#container). |
| `tags` | `any` | `{}` | A mapping of tags to assign to the resource. |

### Container

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | The name of the Container which should be created within the Storage Account. The final name of the resource will be in lowercase. |
| `access_type` | `string` | `private` | | The Access Level configured for this Container. Possible values are `blob`, `container` or `private`. Defaults to `private`. |

## Usage

```ruby
module "storage_account_example" { 
  source                    = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault-secret?ref=3.1.0"

  name                      = "example-name"
  environment_short         = "p"
  environment_instance      = "001"
  resource_group_name       = "example-resource-group-name"
  location                  = "westeurope"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  containers                = [
    {
      name = "example-container-name-1",
    },
    {
      name = "example-container-name-2",
    },
  ]

  tags                      = {}
}
```

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "3.1.0"
    "ModuleId"      = "azure-storage-account"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Storage Account. | |
| `name` | The name of the Storage Account. | |
| `primary_blob_endpoint` | The endpoint URL for blob storage in the primary location. | |
| `primary_connection_string` | The connection string associated with the primary location. | `true` |
| `primary_access_key` | The primary access key for the storage account. | `true` |
