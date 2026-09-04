
data "azurerm_key_vault" "kv" {
  name                = "rsvmkcanada"
  resource_group_name = "Main"
}
data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}
