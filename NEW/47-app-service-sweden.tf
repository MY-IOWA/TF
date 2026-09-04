resource "azurerm_service_plan" "Service_plan_win" {
  name                = "serviceplan-windows"
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
  location            = azurerm_resource_group.rg["swedencentral"].location
  os_type             = "Windows"
  sku_name            = "B1"
}
resource "azurerm_windows_web_app" "web-app-windows" {
  name                = "web-app-windows"
  resource_group_name = azurerm_resource_group.rg["swedencentral"].name
  location            = azurerm_resource_group.rg["swedencentral"].location
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
  branch   = "master"
  repo_url = "https://github.com/MY-IOWA/MK-DSM"
  github_action_configuration {
    generate_workflow_file = true
    code_configuration {
      runtime_stack   = "dotnetcore"
      runtime_version = "9.0"
    }
  }
}
resource "azurerm_route" "sweden-africa" {
  name                   = "sweden-africa"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-mexico" {
  name                   = "sweden-mexico"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-chile" {
  name                   = "sweden-chile"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-japan" {
  name                   = "sweden-japan"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.5.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-korea" {
  name                   = "sweden-korea"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "sweden-australia" {
  name                   = "sweden-australia"
  resource_group_name    = azurerm_resource_group.rg["swedencentral"].name
  route_table_name       = azurerm_route_table.route_table["swedencentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
