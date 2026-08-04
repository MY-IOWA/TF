/*
resource "azurerm_mssql_server" "sql" {
  name                         = "mysqlserver-${random_string.random8.result}"
  resource_group_name          = values(azurerm_resource_group.rg)[5].name
  location                     = values(azurerm_resource_group.rg)[5].location
  version                      = "12.0"
  administrator_login          = "mahesh"
  administrator_login_password = "Test@123user"
}
*/
