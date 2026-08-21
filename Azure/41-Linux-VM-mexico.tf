resource "azurerm_linux_virtual_machine" "RHEL" {
  name                            = "rhelvm-mexicocentral"
  resource_group_name             = azurerm_resource_group.rg["mexicocentral"].name
  location                        = azurerm_resource_group.rg["mexicocentral"].location
  size                            = "Standard_B2als_v2"
  admin_username                  = "mahesh"
  admin_password                  = data.azurerm_key_vault_secret.admin_password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-RHEL.id,
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
}
resource "azurerm_network_interface_security_group_association" "rhelnic-association" {
  network_security_group_id = azurerm_network_security_group.web_nsg["mexicocentral"].id
  network_interface_id      = azurerm_network_interface.nic-RHEL.id
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
  admin_password                  = data.azurerm_key_vault_secret.admin_password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic-ubuntu.id,
  ]
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
resource "azurerm_network_interface_security_group_association" "ubuntunic-association" {
  network_security_group_id = azurerm_network_security_group.web_nsg["mexicocentral"].id
  network_interface_id      = azurerm_network_interface.nic-ubuntu.id
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
resource "azurerm_route" "mexico-india" {
  name                   = "mexico-india"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.0.0.0/16"
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
resource "azurerm_route" "mexico-chile" {
  name                   = "mexico-chile"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.4.0.0/16"
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
resource "azurerm_route" "mexico-australia" {
  name                   = "mexico-australia"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
