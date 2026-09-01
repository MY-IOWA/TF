resource "azurerm_windows_web_app" "web-app-windows" {
  name                = "web-app-windows"
  resource_group_name = "Main"
  location            = "swedencentral"
  service_plan_id     = azurerm_service_plan.Service_plan_win.id
  site_config {
    always_on = false
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = "v9.0"
    }
  }
}
resource "azurerm_app_service_source_control" "windows_git" {
  app_id   = azurerm_windows_web_app.web-app-windows.id
  branch   = "main"
  repo_url = "https://github.com/MY-IOWA/MK-DSM"
}
/*
resource "azurerm_linux_web_app" "web-app-linux" {
  name                = "web-app-linux"
  resource_group_name = "Main"
  location            = "swedencentral"
  service_plan_id     = azurerm_service_plan.Service_plan_lin.id
  site_config {
    always_on = false
    application_stack {
      python_version = "3.14"
    }
  }
}
*/
