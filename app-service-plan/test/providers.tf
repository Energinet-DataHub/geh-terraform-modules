terraform {
  required_version = ">= 0.14.5"

  required_providers {
    azurerm = "=2.40.0"
	  null = "~> 2.1"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}