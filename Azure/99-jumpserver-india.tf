resource "azurerm_windows_virtual_machine" "jumpserver" {
  name                = "jumpserver"
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  location            = azurerm_resource_group.rg["centralindia"].location
  size                = "Standard_D2as_v5"
  priority            = "Spot"
  eviction_policy     = "Deallocate"
  max_bid_price       = -1
  admin_username      = "mahesh"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  network_interface_ids = [
    azurerm_network_interface.nic-jumpserver.id,
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
resource "azurerm_network_interface" "nic-jumpserver" {
  name                  = "nic-jumpserver"
  resource_group_name   = azurerm_resource_group.rg["centralindia"].name
  location              = azurerm_resource_group.rg["centralindia"].location
  ip_forwarding_enabled = true
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["centralindia"].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"
    public_ip_address_id          = azurerm_public_ip.jumpserver_public_ip.id
  }
}
resource "azurerm_public_ip" "jumpserver_public_ip" {
  name                = "jumpserver-public-ip"
  resource_group_name = azurerm_resource_group.rg["centralindia"].name
  location            = azurerm_resource_group.rg["centralindia"].location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_route" "india-mexico" {
  name                   = "india-mexico"
  resource_group_name    = azurerm_resource_group.rg["centralindia"].name
  route_table_name       = azurerm_route_table.route_table["centralindia"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "india-chile" {
  name                   = "india-chile"
  resource_group_name    = azurerm_resource_group.rg["centralindia"].name
  route_table_name       = azurerm_route_table.route_table["centralindia"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
