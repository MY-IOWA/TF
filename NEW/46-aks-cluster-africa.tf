resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.rg["southafricanorth"].location
  resource_group_name = azurerm_resource_group.rg["southafricanorth"].name
  dns_prefix          = "my-aks-cluster-dns"
  node_provisioning_profile {
    mode = "Manual"
  }
  default_node_pool {
    name       = "nodepool01"
    node_count = 1
    vm_size    = "Standard_B2als_v2"
  }
  identity { type = "SystemAssigned" }

}

resource "azurerm_route" "africa-sweden" {
  name                   = "africa-sweden"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
resource "azurerm_route" "africa-mexico" {
  name                   = "africa-mexico"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
resource "azurerm_route" "africa-chile" {
  name                   = "africa-chile"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.50"
}
