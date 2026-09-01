resource "azurerm_service_plan" "Service_plan_win" {
  name                = "serviceplan-windows"
  resource_group_name = "Main"
  location            = "swedencentral"
  os_type             = "Windows"
  sku_name            = "B1"
}
/*
resource "azurerm_service_plan" "Service_plan_lin" {
  name                = "serviceplan-linux"
  resource_group_name = "Main"
  location            = "swedencentral"
  os_type             = "Linux"
  sku_name            = "B1"
}
*/
