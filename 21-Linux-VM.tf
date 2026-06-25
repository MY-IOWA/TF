# B2ats_v2
resource "azurerm_linux_virtual_machine" "linux" {
  for_each                        = local.location_code
  name                            = "linuxvm-${local.naming_suffix}-${each.value}"
  resource_group_name             = azurerm_resource_group.rg[each.key].name
  location                        = azurerm_resource_group.rg[each.key].location
  size                            = "Standard_B2ats_v2"
  admin_username                  = "mahesh"
  admin_password                  = "Test@123user"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
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
resource "azurerm_network_interface" "nic" {
  for_each            = local.location_code
  name                = "nic-${local.naming_suffix}-${each.value}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  ip_configuration {
    name                          = "ipconfig-${local.naming_suffix}-${each.value}"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}