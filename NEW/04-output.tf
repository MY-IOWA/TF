output "naming_suffix" {
  value       = local.naming_suffix
  description = "The generated naming suffix based on the first location's business unit and environment."
  sensitive   = true
}
output "Vnet_ID" {
  value = [for MC in azurerm_virtual_network.vnet : MC.id]
}
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

/*
output "location_code_map" {
  value       = local.location_code
  description = "A map of Azure locations to their corresponding codes."
}
output "location_list" {
  value       = local.location
  description = "The list of location objects with code, location, business unit, and environment."
}
output "storage_account_names" {
  value       = { for loc in local.location : loc.location => "st${random_string.random8.result}${loc.location}" }
  description = "A map of Azure locations to their corresponding storage account names."
}
*/
