resource "azurerm_storage_account" "st_name" {
  name                            = lower(substr("storage${random_string.random6.result}", 0, 20))
  resource_group_name             = azurerm_resource_group.rg["swedencentral"].name
  location                        = azurerm_resource_group.rg["swedencentral"].location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false
  lifecycle {
    ignore_changes = [
      name
    ]
  }
}
resource "azurerm_private_endpoint" "storage_pe" {
  name                = lower("pe-${local.naming_suffix}")
  location            = azurerm_resource_group.rg["swedencentral"].location
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
  subnet_id           = azurerm_subnet.subnet["swedencentral"].id

  private_service_connection {
    name                           = lower("psc-${local.naming_suffix}")
    private_connection_resource_id = azurerm_storage_account.st_name.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
  private_dns_zone_group {
    name                 = "storage-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage_dns_zone.id]
  }
}
resource "azurerm_private_dns_zone" "storage_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage_dns_link" {
  name                = "storage-dns-link"
  private_dns_zone_id = azurerm_private_dns_zone.storage_dns_zone.id
  virtual_network_id  = azurerm_virtual_network.vnet["swedencentral"].id
}
