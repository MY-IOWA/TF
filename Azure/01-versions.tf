terraform {
  required_version = ">=1.12.0"
  backend "azurerm" {
    resource_group_name  = "Main"
    storage_account_name = "storageindiastate2"
    container_name       = "tfstate"
    key                  = "azure.tfstate"
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
    null = {
      source  = "hashicorp/null"
      version = ">=3.2.1"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.7.2"
    }
    external = {
      source  = "hashicorp/external"
      version = ">=2.1.0"
    }
  }
}
