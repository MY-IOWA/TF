resource "azurerm_service_plan" "Service_plan_win" {
  name                = "serviceplan-windows"
  resource_group_name = azurerm_resource_group.AZ400.name
  location            = azurerm_resource_group.AZ400.location
  os_type             = "Windows"
  sku_name            = "F1"
}