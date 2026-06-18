resource "azurerm_storage_account" "st_name" {
  for_each                 = local.location_code
  name                     = substr("storage${random_string.random6.result}${local.location[0].location}", 0, 20)
  resource_group_name      = azurerm_resource_group.rg[each.key].name
  location                 = azurerm_resource_group.rg[each.key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    ignore_changes = [
      name
    ]
  }

}
resource "azurerm_storage_container" "container1" {
  for_each              = local.location_code
  name                  = lower("container-${local.naming_suffix}")
  storage_account_id    = azurerm_storage_account.st_name[each.key].id
  container_access_type = "private"
}
resource "azurerm_storage_blob" "blob1" {
  for_each             = local.location_code
  name                 = lower("blob-${local.naming_suffix}")
  storage_container_id = azurerm_storage_container.container1[each.key].id
  type                 = "Block"
  source_content       = "This is a sample blob content for ${local.naming_suffix}"
}