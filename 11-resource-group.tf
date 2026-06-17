resource "azurerm_resource_group" "Terraform-Main" {
  name     = "Terraform-Main"
  location = "Central India"
}

resource "azurerm_resource_group" "rg" {
  for_each = local.location_code
  name     = "rg-${each.value}"
  location = each.key
}