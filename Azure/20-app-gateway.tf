resource "azurerm_application_gateway" "app_gateway" {
  name                = "india-app-gateway"
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  location            = azurerm_resource_group.rg["centralindia"].location

  sku {
    name     = "Basic"
    tier     = "Basic"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.gateway_subnet.id
  }

  frontend_port {
    name = "frontendPort"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontendIpConfig"
    public_ip_address_id = azurerm_public_ip.gw_public_ip.id
  }

  backend_address_pool {
    name = "backendPool"
  }

  backend_http_settings {
    name                  = "backendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "httpListener"
    frontend_ip_configuration_name = "frontendIpConfig"
    frontend_port_name             = "frontendPort"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener"
    backend_address_pool_name   = "backendPool"
    backend_http_settings_name  = "backendHttpSettings"
    priority                   = 100
  }
  
}
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "gateway-subnet"
  resource_group_name  = azurerm_resource_group.rg["centralindia"].name
  virtual_network_name = azurerm_virtual_network.vnet["centralindia"].name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "gw_public_ip" {
  name                = "gateway-PIP"
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  location            = azurerm_resource_group.rg["centralindia"].location
  allocation_method   = "Static"
  sku                 = "Standard"
}