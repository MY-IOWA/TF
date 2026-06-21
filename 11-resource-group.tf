resource "azurerm_resource_group" "rg" {
  for_each = local.location_code
  name     = "MyRG-${each.value}"
  location = each.key
}