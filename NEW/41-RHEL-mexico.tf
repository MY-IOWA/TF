resource "azurerm_linux_virtual_machine" "RHEL" {
  count                           = 2
  name                            = "rhelvm-mexicocentral-${count.index}"
  resource_group_name             = azurerm_resource_group.rg["mexicocentral"].name
  location                        = azurerm_resource_group.rg["mexicocentral"].location
  size                            = "Standard_B2als_v2"
  admin_username                  = "mahesh"
  admin_password                  = data.azurerm_key_vault_secret.admin_password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-RHEL[count.index].id,
  ]
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
  custom_data = filebase64("${path.module}/RHEL.sh")
}
resource "azurerm_network_interface_security_group_association" "rhelnic-association" {
  count                     = 2
  network_security_group_id = azurerm_network_security_group.web_nsg["mexicocentral"].id
  network_interface_id      = azurerm_network_interface.nic-RHEL[count.index].id
}
resource "azurerm_network_interface" "nic-RHEL" {
  count               = 2
  name                = "nic-rhel-mexicocentral-${count.index}"
  resource_group_name = azurerm_resource_group.rg["mexicocentral"].name
  location            = azurerm_resource_group.rg["mexicocentral"].location
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["mexicocentral"].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_lb" "RHEL-lb-mexico" {
  name                = "lb-mexicocentral"
  resource_group_name = azurerm_resource_group.rg["mexicocentral"].name
  location            = azurerm_resource_group.rg["mexicocentral"].location
  sku                 = "Standard"
  frontend_ip_configuration {
    name                          = "lb-frontend"
    subnet_id                     = azurerm_subnet.subnet["mexicocentral"].id
    private_ip_address_allocation = "static"
    private_ip_address            = "10.3.0.100"
  }
}
resource "azurerm_lb_backend_address_pool" "RHEL-backend-mexico" {
  name            = "RHEL-lb-backend"
  loadbalancer_id = azurerm_lb.RHEL-lb-mexico.id
}
resource "azurerm_lb_probe" "RHEL-lb-probe-mexico" {
  name            = "RHEL-lb-probe"
  loadbalancer_id = azurerm_lb.RHEL-lb-mexico.id
  protocol        = "Tcp"
  port            = 80
}
resource "azurerm_lb_rule" "RHEL-lb-rule-mexico" {
  name                           = "RHEL-lb-rule"
  loadbalancer_id                = azurerm_lb.RHEL-lb-mexico.id
  frontend_ip_configuration_name = "lb-frontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.RHEL-backend-mexico.id]
  probe_id                       = azurerm_lb_probe.RHEL-lb-probe-mexico.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc" {
  count                   = length(azurerm_network_interface.nic-RHEL)
  network_interface_id    = azurerm_network_interface.nic-RHEL[count.index].id
  ip_configuration_name   = azurerm_network_interface.nic-RHEL[count.index].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.RHEL-backend-mexico.id
}
resource "azurerm_route" "mexico-sweden" {
  name                   = "mexico-sweden"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
resource "azurerm_route" "mexico-africa" {
  name                   = "mexico-africa"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
resource "azurerm_route" "mexico-chile" {
  name                   = "mexico-chile"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
