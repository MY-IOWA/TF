resource "azurerm_service_plan" "Service_plan_win" {
  name                = "serviceplan-windows"
  resource_group_name = values(azurerm_resource_group.rg)[5].name
  location            = values(azurerm_resource_group.rg)[5].location
  os_type             = "Windows"
  sku_name            = "F1"
}
