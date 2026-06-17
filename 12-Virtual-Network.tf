resource "azurerm_virtual_network" "vnet" {
  for_each            = local.location_code
  name                = "vnet-${local.naming_suffix}-${each.value}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
resource "azurerm_subnet" "subnet" {
  for_each             = local.location_code
  name                 = "subnet-${local.naming_suffix}-${each.value}"
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = ["10.0.1.0/24"]
}