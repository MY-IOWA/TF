resource "azurerm_route_table" "route_table" {
  for_each            = local.location_code
  name                = "rt-${local.naming_suffix}-${each.value}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
