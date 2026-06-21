resource "azurerm_resource_group" "rg" {
  for_each = local.location_code
  name     = "RG-${each.value}"
  location = each.key
}