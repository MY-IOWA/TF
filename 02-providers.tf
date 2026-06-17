provider "azurerm" {
  features {}
  client_id       = "ed1b5684-0866-4873-926f-cfc0fe9467b0"
  client_secret   = "MCj8Q~c-xT6xKxgpLj9T3xsMOVvhkgPCzzcnCa-j"
  tenant_id       = "a1de93d5-ae36-4121-bf1e-c6d2842e5171"
  subscription_id = "307d7ff5-4e27-4cf0-b4df-f262f08102e7"
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