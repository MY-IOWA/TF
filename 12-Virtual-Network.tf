resource "azurerm_virtual_network" "vnet" {
  for_each            = local.location_code
  name                = "vnet-${local.naming_suffix}-${each.value}"
  address_space       = [local.location_cidr[each.key]]
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}
resource "azurerm_subnet" "subnet" {
  for_each             = local.location_code
  name                 = "subnet-${local.naming_suffix}-${each.value}"
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = [cidrsubnet(tolist(azurerm_virtual_network.vnet[each.key].address_space)[0], 8, 0)]
}
/*

resource "azurerm_subnet" "gateway_subnet" {
  for_each             = local.location_code
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = [cidrsubnet(tolist(azurerm_virtual_network.vnet[each.key].address_space)[0], 8, 1)]
}
resource "azurerm_public_ip" "PublicIP" {
  for_each            = local.location_code
  name                = "publicip-${local.naming_suffix}-${each.value}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  allocation_method   = "Static"
  zones               = ["1", "2", "3"]
}
resource "azurerm_virtual_network_gateway" "VNetGW" {
  for_each            = local.location_code
  name                = "vnetgw-${local.naming_suffix}-${each.value}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  bgp_enabled         = false
  sku                 = "VpnGw3AZ"
  ip_configuration {
    name                          = "vnetgw-ipconfig-${local.naming_suffix}-${each.value}"
    public_ip_address_id          = azurerm_public_ip.PublicIP[each.key].id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet[each.key].id
  }
}
*/