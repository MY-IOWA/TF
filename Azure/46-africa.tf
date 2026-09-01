/*
resource "azurerm_windows_virtual_machine" "win" {
  count               = 2
  name                = "winvm-${count.index}"
  resource_group_name = azurerm_resource_group.rg["southafricanorth"].name
  location            = azurerm_resource_group.rg["southafricanorth"].location
  size                = "Standard_B2als_v2"
  admin_username      = "mahesh"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  network_interface_ids = [
    azurerm_network_interface.nic-win[count.index].id,
  ]
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
}
resource "azurerm_network_interface" "nic-win" {
  count               = 2
  name                = "nic-win-${count.index}"
  resource_group_name = azurerm_resource_group.rg["southafricanorth"].name
  location            = azurerm_resource_group.rg["southafricanorth"].location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["southafricanorth"].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_lb" "lb-southafricanorth" {
  name                = "LoadBalancer-southafricanorth"
  location            = azurerm_resource_group.rg["southafricanorth"].location
  resource_group_name = azurerm_resource_group.rg["southafricanorth"].name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "LoadBalancerFrontEnd"
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.2.0.100"
    subnet_id                     = azurerm_subnet.subnet["southafricanorth"].id
  }
}
resource "azurerm_lb_backend_address_pool" "backend_pool_southafricanorth" {
  name            = "BackendPool"
  loadbalancer_id = azurerm_lb.lb-southafricanorth.id
}
resource "azurerm_lb_probe" "hp_southafricanorth" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.lb-southafricanorth.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}
resource "azurerm_lb_rule" "lb_rule_southafricanorth" {
  name                           = "LoadBalancerRule"
  loadbalancer_id                = azurerm_lb.lb-southafricanorth.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.lb-southafricanorth.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.hp_southafricanorth.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association-win" {
  network_interface_id    = azurerm_network_interface.nic-win[0].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool_southafricanorth.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association-win-1" {
  network_interface_id    = azurerm_network_interface.nic-win[1].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool_southafricanorth.id
}
*/
resource "azurerm_route" "africa-sweden" {
  name                   = "africa-sweden"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-mexico" {
  name                   = "africa-mexico"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-chile" {
  name                   = "africa-chile"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-japan" {
  name                   = "africa-japan"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.5.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-korea" {
  name                   = "africa-korea"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-australia" {
  name                   = "africa-australia"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
