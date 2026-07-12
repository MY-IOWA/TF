resource "azurerm_log_analytics_workspace" "aks_monitoring" {
  name                = "aks-monitoring"
  location            = azurerm_resource_group.rg["koreacentral"].location
  resource_group_name = azurerm_resource_group.rg["koreacentral"].name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg["koreacentral"].location
  resource_group_name = azurerm_resource_group.rg["koreacentral"].name
  dns_prefix          = "aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2als_v2"
  }

  identity {
    type = "SystemAssigned"
  }
  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.aks_monitoring.id
  }
}