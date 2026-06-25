resource "azurerm_mssql_database" "database" {
  name         = "database1"
  server_id    = azurerm_mssql_server.sql.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "Basic"
  depends_on = [
    azurerm_mssql_server.sql
  ]
}
