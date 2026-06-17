terraform {
  /*backend "remote" {
    organization = "MK-IOWA-TEST"
    workspaces {
      name = "Main"
    }*/
  
  backend "azurerm" {
    resource_group_name  = "Terraform-Main"
    storage_account_name = "storagescm71pke"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = "~>1.12.0"
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
  }
}