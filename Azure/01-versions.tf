terraform {
  required_version = ">=1.12.0"
  backend "azurerm" {
    resource_group_name  = "Main"
    storage_account_name = "storageindiastate2"
    container_name       = "tfstate"
    key                  = "azure.tfstate"
  }
}
