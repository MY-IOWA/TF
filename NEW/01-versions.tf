terraform {
  required_version = ">=1.12.0"
  /*  backend "remote" {
    organization = "MK-IOWA-TEST"
    workspaces {
      name = "Main"
    }
  }
  */
  backend "azurerm" {
    resource_group_name  = "TEST"
    storage_account_name = "storageindiastate"
    container_name       = "tfstate"
    key                  = "new.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "azurerm"
      version = ">=4.66.0"
    }
  }
}
