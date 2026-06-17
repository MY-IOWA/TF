resource "azurerm_storage_account" "st_name" {
    for_each = local.location_code
  name                     = "substring(st${random_string.random8.result}${local.location[0].location }, 0, 24)"
  resource_group_name      = azurerm_resource_group.rg[each.key].name
  location                 = azurerm_resource_group.rg[each.key].location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
}
resource "azurerm_storage_container" "container1" {
    for_each = local.location_code
  name                  = lower("container-${local.naming_suffix}")
  storage_account_name  = azurerm_storage_account.st_name[each.key].name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "blob1" {
    for_each = local.location_code
  name                   = lower("blob-${local.naming_suffix}")
  storage_account_name   = azurerm_storage_account.st_name[each.key].name
  storage_container_id = azurerm_storage_container.container1[each.key].id
  type                   = "Block"
  source_content         = "This is a sample blob content for ${local.naming_suffix}"
}