output "naming_suffix" {
  value       = local.naming_suffix
  description = "The generated naming suffix based on the first location's business unit and environment."
  
}
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