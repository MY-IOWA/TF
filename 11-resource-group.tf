resource "azurerm_resource_group" "rg" {
  for_each = local.location_code
  name     = "MyRG-${each.value}"
  location = each.key
}
resource "azurerm_resource_group" "AZ400" {
  name     = "AZ400"
  location = "centralindia"

}