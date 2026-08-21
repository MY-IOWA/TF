
resource "azurerm_virtual_network_peering" "mexico-japan" {
  name                      = "mexico-japan"
  resource_group_name       = azurerm_resource_group.rg["mexicocentral"].name
  virtual_network_name      = azurerm_virtual_network.vnet["mexicocentral"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["japanwest"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "japan-mexico" {
  name                      = "japan-mexico"
  resource_group_name       = azurerm_resource_group.rg["japanwest"].name
  virtual_network_name      = azurerm_virtual_network.vnet["japanwest"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["mexicocentral"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "chile-japan" {
  name                      = "chile-japan"
  resource_group_name       = azurerm_resource_group.rg["chilecentral"].name
  virtual_network_name      = azurerm_virtual_network.vnet["chilecentral"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["japanwest"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "japan-chile" {
  name                      = "japan-chile"
  resource_group_name       = azurerm_resource_group.rg["japanwest"].name
  virtual_network_name      = azurerm_virtual_network.vnet["japanwest"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["chilecentral"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "sweden-india" {
  name                      = "sweden-india"
  resource_group_name       = azurerm_resource_group.rg["swedencentral"].name
  virtual_network_name      = azurerm_virtual_network.vnet["swedencentral"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["centralindia"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "india-sweden" {
  name                      = "india-sweden"
  resource_group_name       = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name      = azurerm_virtual_network.vnet["centralindia"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["swedencentral"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "africa-india" {
  name                      = "africa-india"
  resource_group_name       = azurerm_resource_group.rg["southafricanorth"].name
  virtual_network_name      = azurerm_virtual_network.vnet["southafricanorth"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["centralindia"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "india-africa" {
  name                      = "india-africa"
  resource_group_name       = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name      = azurerm_virtual_network.vnet["centralindia"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["southafricanorth"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "japan-india" {
  name                      = "japan-india"
  resource_group_name       = azurerm_resource_group.rg["japanwest"].name
  virtual_network_name      = azurerm_virtual_network.vnet["japanwest"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["centralindia"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
resource "azurerm_virtual_network_peering" "india-japan" {
  name                      = "india-japan"
  resource_group_name       = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name      = azurerm_virtual_network.vnet["centralindia"].name
  remote_virtual_network_id = azurerm_virtual_network.vnet["japanwest"].id
  allow_virtual_network_access = true
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  use_remote_gateways           = false
}
