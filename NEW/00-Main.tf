terraform {
  required_version = ">=1.12.0"
  backend "azurerm" {
    resource_group_name  = "Main"
    storage_account_name = "storageindiastate2"
    container_name       = "tfstate"
    key                  = "new.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = ">=4.66.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.5.1"
    }
  }
}
