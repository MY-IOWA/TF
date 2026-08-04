provider "azurerm" {
  features {}
}
resource "random_string" "random4" {
  length  = 4
  lower   = true
  upper   = false
  numeric = true
  special = false
}
resource "random_string" "random6" {
  length  = 6
  lower   = true
  upper   = false
  numeric = true
  special = false
}
resource "random_string" "random8" {
  length  = 8
  lower   = true
  upper   = false
  numeric = true
  special = false
}