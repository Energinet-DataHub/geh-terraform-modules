# Azure Key Vault

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources:

- [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)

## Prerequisites

- Terraform version 1.1.2+
- AzureRM provider version 2.91.0+

## Arguments and defaults

See [variables.tf](./variables.tf)

### Access Policy

An `access_policy` item consists of the following:

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `tenant_id` | `string` | | **Required** | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. Changing this forces a new resource to be created. |
| `object_id` | `string` | | **Required** | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. Changing this forces a new resource to be created. |
| `secret_permissions` | `list(string)` | | | List of secret permissions, must be one or more from the following: `Backup`, `Delete`, `Get`, `List`, `Purge`, `Recover`, `Restore` and `Set`. |
| `key_permissions` | `list(string)` | | | List of key permissions, must be one or more from the following: `Backup`, `Create`, `Decrypt`, `Delete`, `Encrypt`, `Get`, `Import`, `List`, `Purge`, `Recover`, `Restore`, `Sign`, `UnwrapKey`, `Update`, `Verify` and `WrapKey`. |
| `certificate_permissions` | `list(string)` | | | List of certificate permissions, must be one or more from the following: `Backup`, `Create`, `Delete`, `DeleteIssuers`, `Get`, `GetIssuers`, `Import`, `List`, `ListIssuers`, `ManageContacts`, `ManageIssuers`, `Purge`, `Recover`, `Restore`, `SetIssuers` and `Update`. |
| `storage_permissions` | `list(string)` | | | List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`. |

## Usage

```ruby
module "key_vault_example" {
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=6.0.0"

  name                  = "example-name"
  project_name          = "example-project-name"
  environment_short     = "p"
  environment_instance  = "001"
  resource_group_name   = "example-resource-group-name"
  location              = "westeurope"
  sku_name              = "standard"
  access_policies       = [
    {
      object_id               = "example-object-id"
      secret_permissions      = ["backup", "delete", "get"]
      certificate_permissions = ["backup", "create", "delete"]
      key_permissions         = ["backup", "create", "decrypt"]
      storage_permissions     = ["backup", "delete", "deletesas"]
    },
    {
      object_id               = "example-object-id"
      secret_permissions      = ["backup", "delete"]
      certificate_permissions = ["backup", "create"]
      key_permissions         = ["backup", "create"]
      storage_permissions     = ["backup", "delete"]
    }
  ]
}
```

Two tags are added by default:

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "6.0.0"
    "ModuleId"      = "azure-key-vault"
  }
}
```

## Outputs

See [outputs.tf](./outputs.tf)
