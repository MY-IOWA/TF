resource "azurerm_windows_virtual_machine" "win" {
  for_each            = local.location_code
  name                = "winvm-${local.naming_suffix}-${each.value}"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = azurerm_resource_group.rg[each.key].location
  size                = "Standard_B2als_v2"
  admin_username      = "mahesh"
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  network_interface_ids = [
    azurerm_network_interface.nic-win[each.key].id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_network_interface" "nic-win" {
  for_each            = local.location_code
  name                = "nic-win-${local.naming_suffix}-${each.value}"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = azurerm_resource_group.rg[each.key].location

  ip_configuration {
    name                          = "ipconfig-${local.naming_suffix}-${each.value}"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
