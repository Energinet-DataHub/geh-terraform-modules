# Azure Key Vault

- [Resources Created](#resources-created)
- [Prerequisites](#prerequisites)
- [Arguments and defaults](#arguments-and-defaults)
- [Usage](#usage)
- [Outputs](#outputs)

## Resources Created

This module creates the following resources.

- [Azure Key Vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault)
- [Azure Key Vault Access Policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy)
- [Azure Monitor Diagnostic Setting](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting)

## Prerequisites

- Terraform version 1.1.5+
- AzureRM provider version 2.70.0+

## Arguments and defaults

| Name | Type | Default | Required | Description |
|-|-|-|-|-|
| `name` | `string` | | **Required** | Specifies the name of the Key Vault. Changing this forces a new resource to be created. The final name of the resource will follow this syntax `kv{var.name}{var.environment_short}{var.environment_instance}` and be in lowercase. |
| `project_name` | `string` | | **Required** | Name of the project this infrastructure is a part of. |
| `environment_short` | `string` | | **Required** | The short value name of your environment. |
| `environment_instance` | `number` | | **Required** |  The instance number of your environment. |
| `resource_group_name` | `string` | | **Required** | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. |
| `location` | `string` | | **Required** | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| `sku_name` | `string` | | **Required** | The Name of the SKU used for this Key Vault. Possible values are `standard` and `premium`. |
| `access_policies` | `list` | `[]` | |  A list of objects describing the Key Vault access policies. See [Access Policy](#access-policy). |
| `enabled_for_template_deployment` | `bool` | `false` | | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false. |
| `log_analytics_workspace_id` | `string` | | **Required** | | ID of Log Analytics Workspace associated with the Key Vault  |
| `tags` | `any` | `{}` | | A mapping of tags to assign to the resource. |


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
  source                = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/key-vault?ref=5.1.0"

  name                       = "example-name"
  project_name               = "example-project-name"
  environment_short          = "p"
  environment_instance       = "001"
  resource_group_name        = "example-resource-group-name"
  location                   = "westeurope"
  sku_name                   = "standard"
  log_analytics_workspace_id = "example-log-analytics-workspace"
  access_policies            = [
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

Two tags is added by default

```ruby
locals {
  module_tags = {
    "ModuleVersion" = "5.6.0"
    "ModuleId"      = "azure-key-vault"
  }
}
```

## Outputs

| Name | Description | Sensitive |
|-|-|-|
| `id` | The ID of the Key Vault. | |
| `name` | The name of the Key Vault. | |
| `vault_uri` | The URI of the Key Vault, used for performing operations on keys and secrets. | |
