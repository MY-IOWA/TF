resource "azurerm_storage_account" "storage" {
  name                     = "storage${random_string.random8.result}"
  resource_group_name      = "Terraform-Main"
  location                 = "Central India"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
