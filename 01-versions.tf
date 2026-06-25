terraform {
  required_version = ">=1.12.0"
  backend "remote" {
    organization = "MK-IOWA-TEST"
    workspaces {
      name = "Main"
    }
  }
  /*
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terraformstorageindia"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  */
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