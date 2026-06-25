resource "azurerm_windows_web_app" "web-app-windows" {
  name                = "web-app-windows"
  resource_group_name = azurerm_resource_group.AZ400.name
  location            = azurerm_resource_group.AZ400.location
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
