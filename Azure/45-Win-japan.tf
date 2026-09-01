
resource "azurerm_windows_virtual_machine" "virtual_appliance" {
  name                = "Win-virtual-app"
  resource_group_name = azurerm_resource_group.rg["japanwest"].name
  location            = azurerm_resource_group.rg["japanwest"].location
  size                = "Standard_B2als_v2"
  admin_username      = "mahesh"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  network_interface_ids = [
    azurerm_network_interface.nic-virtual-appliance.id,
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
resource "azurerm_network_interface" "nic-virtual-appliance" {
  name                  = "nic-virtual-appliance"
  resource_group_name   = azurerm_resource_group.rg["japanwest"].name
  location              = azurerm_resource_group.rg["japanwest"].location
  ip_forwarding_enabled = true
  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet["japanwest"].id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.5.0.4"
  }
}
# Set-Service -Name RemoteAccess -StartupType Automatic; Start-Service -Name RemoteAccess; Get-Service -Name RemoteAccess
