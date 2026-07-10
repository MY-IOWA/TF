resource "azurerm_public_ip" "vpn_india_public_ip" {
  name                = "vpn-gateway-india-public-ip"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "vpn-gateway-centralindia"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw3AZ"

  ip_configuration {
    name                          = "vnetgw-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_india_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet["centralindia"].id
  }
}
resource "azurerm_public_ip" "vpn_aus_public_ip" {
  name                = "vpn-gateway-aus-public-ip"
  location            = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name = azurerm_resource_group.rg["australiaeast"].name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_virtual_network_gateway" "vpn_aus_gw" {
  name                = "vpn-gateway-australiaeast"
  location            = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name = azurerm_resource_group.rg["australiaeast"].name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = "VpnGw3AZ"

  ip_configuration {
    name                          = "vnetgw-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_aus_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet["australiaeast"].id
  }
}
resource "azurerm_virtual_network_gateway_connection" "vpn_connection_india" {
  name                            = "vpn-connection-india-aus"
  location                        = azurerm_resource_group.rg["centralindia"].location
  resource_group_name             = azurerm_resource_group.rg["centralindia"].name
  type                            = "IPsec"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_aus_gw.id
  shared_key                      = "Test@123user"
}
resource "azurerm_virtual_network_gateway_connection" "vpn_connection_aus" {
  name                            = "vpn-connection-aus-india"
  location                        = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name             = azurerm_resource_group.rg["australiaeast"].name
  type                            = "IPsec"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_aus_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gw.id
  shared_key                      = "Test@123user"
}
