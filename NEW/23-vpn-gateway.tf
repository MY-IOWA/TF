resource "azurerm_public_ip" "vpn_india_public_ip" {
  name                = "vpn-gateway-india-public-ip"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}
resource "azurerm_subnet" "gateway_subnet_india" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name = azurerm_virtual_network.vnet["centralindia"].name
  address_prefixes     = ["10.0.50.0/24"]
}
resource "azurerm_virtual_network_gateway" "vpn_gw" {
  name                = "vpn-gateway-centralindia"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  bgp_enabled         = false
  sku                 = "VpnGw3AZ"

  ip_configuration {
    name                          = "vnetgw-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_india_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet_india.id
  }
}
resource "azurerm_subnet" "gateway_subnet_australia" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg["australiaeast"].name
  virtual_network_name = azurerm_virtual_network.vnet["australiaeast"].name
  address_prefixes     = ["10.7.50.0/24"]
}
resource "azurerm_public_ip" "vpn_aus_public_ip" {
  name                = "vpn-gateway-aus-public-ip"
  location            = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name = azurerm_resource_group.rg["australiaeast"].name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}
resource "azurerm_virtual_network_gateway" "vpn_aus_gw" {
  name                = "vpn-gateway-australiaeast"
  location            = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name = azurerm_resource_group.rg["australiaeast"].name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  bgp_enabled         = false
  sku                 = "VpnGw3AZ"

  ip_configuration {
    name                          = "vnetgw-ipconfig"
    public_ip_address_id          = azurerm_public_ip.vpn_aus_public_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet_australia.id
  }
}
resource "azurerm_local_network_gateway" "local_gw_india" {
  name                = "local-gateway-india"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  gateway_address     = azurerm_public_ip.vpn_india_public_ip.ip_address
  address_space       = ["10.5.0.0/16"]
}

resource "azurerm_local_network_gateway" "local_gw_aus" {
  name                = "local-gateway-aus"
  location            = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name = azurerm_resource_group.rg["australiaeast"].name
  gateway_address     = azurerm_public_ip.vpn_aus_public_ip.ip_address
  address_space       = ["10.5.0.0/16"]
}
resource "azurerm_virtual_network_gateway_connection" "vpn_connection_india" {
  name                            = "vpn-connection-india-aus"
  location                        = azurerm_resource_group.rg["centralindia"].location
  resource_group_name             = azurerm_resource_group.rg["centralindia"].name
  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_aus_gw.id
  shared_key                      = "Test@123user"
}
resource "azurerm_virtual_network_gateway_connection" "vpn_connection_aus" {
  name                            = "vpn-connection-aus-india"
  location                        = azurerm_resource_group.rg["australiaeast"].location
  resource_group_name             = azurerm_resource_group.rg["australiaeast"].name
  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpn_aus_gw.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gw.id
  shared_key                      = "Test@123user"
}
