
resource "azurerm_subnet" "gw_subnet" {
  name                 = "app-gateway-subnet"
  resource_group_name  = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name = azurerm_virtual_network.vnet["centralindia"].name
  address_prefixes     = ["10.0.10.0/24"]
}
resource "azurerm_public_ip" "app_gw_public_ip" {
  name                = "app-gateway-india-public-ip"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  allocation_method   = "Static"
  sku                 = "Standard"
}
resource "azurerm_application_gateway" "india-app-gateway" {
  name                = "india-app-gateway"
  location            = azurerm_resource_group.rg["centralindia"].location
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "app-gateway-ip-config"
    subnet_id = azurerm_subnet.gw_subnet.id
  }
  frontend_ip_configuration {
    name                 = "mk-frontend-ip"
    public_ip_address_id = azurerm_public_ip.app_gw_public_ip.id
  }
  backend_address_pool {
    name         = "backend-pool"
    ip_addresses = ["10.1.0.100", "10.5.0.100", "10.6.0.100", "10.7.0.100"]
  }
  frontend_port {
    port = "80"
    name = "frontend-port-80"
  }
  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = "80"
    protocol              = "Http"
    request_timeout       = 30
  }
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "mk-frontend-ip"
    frontend_port_name             = "frontend-port-80"
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = "routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
    priority                   = 100
  }
}
