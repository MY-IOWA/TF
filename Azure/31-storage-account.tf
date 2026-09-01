resource "azurerm_storage_account" "st_name" {
  name                            = lower(substr("storage${random_string.random6.result}", 0, 20))
  resource_group_name             = "Main"
  location                        = "centralindia"
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
  location            = "centralindia"
  resource_group_name = "Main"
  subnet_id           = azurerm_subnet.subnet["centralindia"].id

  private_service_connection {
    name                           = lower("psc-${local.naming_suffix}")
    private_connection_resource_id = azurerm_storage_account.st_name.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
