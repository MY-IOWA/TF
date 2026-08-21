/*
resource "azurerm_service_plan" "Service_plan_win" {
  name                = "serviceplan-windows"
  resource_group_name = "Main"
  location            = "eastus"
  os_type             = "Windows"
  sku_name            = "F1"
}
resource "azurerm_windows_web_app" "web-app-windows" {
  name                = "web-app-windows"
  resource_group_name = "Main"
  location            = "eastus"
  service_plan_id     = azurerm_service_plan.Service_plan_win.id
  site_config {
    always_on = false
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  depends_on = [
    azurerm_service_plan.Service_plan_win
  ]
}
*/
