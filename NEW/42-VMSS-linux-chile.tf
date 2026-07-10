resource "azurerm_linux_virtual_machine_scale_set" "vmss-linux" {
  name                            = "vmss-lin"
  location                        = azurerm_resource_group.rg["chilecentral"].location
  resource_group_name             = azurerm_resource_group.rg["chilecentral"].name
  sku                             = "Standard_B2als_v2"
  instances                       = 2
  admin_username                  = "mahesh"
  admin_password                  = "Test@123user"
  disable_password_authentication = false
  custom_data                     = base64encode(file("${path.module}/ubuntu.sh"))
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  network_interface {
    name    = "nic-vmss-linux-chilecentral"
    primary = true

    ip_configuration {
      name                                   = "ipconfig1"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet["chilecentral"].id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_pool_chilecentral.id]
    }
  }
}



resource "azurerm_lb" "lb-chilecentral" {
  name                = "LoadBalancer-chilecentral"
  location            = azurerm_resource_group.rg["chilecentral"].location
  resource_group_name = azurerm_resource_group.rg["chilecentral"].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontEnd"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.4.0.100"
    subnet_id                     = azurerm_subnet.subnet["chilecentral"].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool_chilecentral" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.lb-chilecentral.id
}
resource "azurerm_lb_probe" "hp_chilecentral" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.lb-chilecentral.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}
resource "azurerm_lb_rule" "lb_rule_chilecentral" {
  name                           = "LoadBalancerRule"
  loadbalancer_id                = azurerm_lb.lb-chilecentral.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb-chilecentral.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.hp_chilecentral.id
}
resource "azurerm_route" "chile-mexico" {
  name                   = "chile-mexico"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-sweden" {
  name                   = "chile-sweden"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-africa" {
  name                   = "chile-africa"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-australia" {
  name                   = "chile-australia"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-india" {
  name                   = "chile-india"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-korea" {
  name                   = "chile-korea"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
