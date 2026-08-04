resource "azurerm_windows_virtual_machine_scale_set" "vmss-win" {
  name                = "vmss-win"
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
  location            = azurerm_resource_group.rg["swedencentral"].location
  instances           = 2
  sku                 = "Standard_B2als_v2"
  admin_username      = "mahesh"
  admin_password      = "Test@123user"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-g2"
    version   = "latest"
  }
  network_interface {
    name    = "nic-vmss-win-swedencentral"
    primary = true

    ip_configuration {
      name                                   = "ipconfig1"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet["swedencentral"].id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool_swedencentral.id]
    }
  }
}
resource "azurerm_lb" "lb-swedencentral" {
  name                = "LoadBalancer-swedencentral"
  location            = azurerm_resource_group.rg["swedencentral"].location
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontEnd"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.1.0.100"
    subnet_id                     = azurerm_subnet.subnet["swedencentral"].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool_swedencentral" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.lb-swedencentral.id
}
resource "azurerm_lb_probe" "hp_swedencentral" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.lb-swedencentral.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}
resource "azurerm_lb_rule" "lb_rule_swedencentral" {
  name                           = "LoadBalancerRule"
  loadbalancer_id                = azurerm_lb.lb-swedencentral.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb-swedencentral.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.hp_swedencentral.id
}
resource "azurerm_route" "sweden-africa" {
  name                   = "sweden-africa"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-mexico" {
  name                   = "sweden-mexico"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-chile" {
  name                   = "sweden-chile"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-japan" {
  name                   = "sweden-japan"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.5.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-korea" {
  name                   = "sweden-korea"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-australia" {
  name                   = "sweden-australia"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
