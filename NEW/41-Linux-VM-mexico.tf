resource "azurerm_linux_virtual_machine" "RHEL" {
  name                            = "rhelvm-mexicocentral"
  resource_group_name             = azurerm_resource_group.rg["mexicocentral"].name
  location                        = azurerm_resource_group.rg["mexicocentral"].location
  size                            = "Standard_B2als_v2"
  admin_username                  = "mahesh"
  admin_password                  = "Test@123user"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-RHEL.id,
  ]
  custom_data = base64encode(file("${path.module}/RHEL.sh"))
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "nic-RHEL" {
  name                = "nic-rhel-mexicocentral"
  resource_group_name = azurerm_resource_group.rg["mexicocentral"].name
  location            = azurerm_resource_group.rg["mexicocentral"].location
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["mexicocentral"].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_linux_virtual_machine" "ubuntu" {
  name                            = "ubuntuvm-mexicocentral"
  resource_group_name             = azurerm_resource_group.rg["mexicocentral"].name
  location                        = azurerm_resource_group.rg["mexicocentral"].location
  size                            = "Standard_B2als_v2"
  admin_username                  = "mahesh"
  admin_password                  = "Test@123user"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-ubuntu.id,
  ]
  custom_data = base64encode(file("${path.module}/ubuntu.sh"))
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "nic-ubuntu" {
  name                = "nic-ubuntu-mexicocentral"
  resource_group_name = azurerm_resource_group.rg["mexicocentral"].name
  location            = azurerm_resource_group.rg["mexicocentral"].location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["mexicocentral"].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_lb" "lb-mexicocentral" {
  name                = "LoadBalancer-mexicocentral"
  location            = azurerm_resource_group.rg["mexicocentral"].location
  resource_group_name = azurerm_resource_group.rg["mexicocentral"].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontEnd"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.3.0.100"
    subnet_id                     = azurerm_subnet.subnet["mexicocentral"].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool_mexicocentral" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.lb-mexicocentral.id
}
resource "azurerm_lb_probe" "hp_mexicocentral" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.lb-mexicocentral.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}
resource "azurerm_lb_rule" "lb_rule_mexicocentral" {
  name                           = "LoadBalancerRule"
  loadbalancer_id                = azurerm_lb.lb-mexicocentral.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb-mexicocentral.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.hp_mexicocentral.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association-RHEL" {
  network_interface_id    = azurerm_network_interface.nic-RHEL.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool_mexicocentral.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association_ubuntu" {
  network_interface_id    = azurerm_network_interface.nic-ubuntu.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool_mexicocentral.id
}
resource "azurerm_route" "mexico-chile" {
  name                   = "mexico-chile"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-sweden" {
  name                   = "mexico-sweden"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-africa" {
  name                   = "mexico-africa"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-australia" {
  name                   = "mexico-australia"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-india" {
  name                   = "mexico-india"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-korea" {
  name                   = "mexico-korea"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
