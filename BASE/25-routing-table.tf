resource "azurerm_route_table" "route_table" {
  for_each            = local.location_code
  name                = "rt-${local.naming_suffix}-${each.value}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
}

resource "azurerm_route" "india-mexico" {
  name                   = "india-mexico"
  resource_group_name    = azurerm_resource_group.rg["centralindia"].name
  route_table_name       = azurerm_route_table.route_table["centralindia"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "india-chile" {
  name                   = "india-chile"
  resource_group_name    = azurerm_resource_group.rg["centralindia"].name
  route_table_name       = azurerm_route_table.route_table["centralindia"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
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

resource "azurerm_route" "africa-sweden" {
  name                   = "africa-sweden"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-mexico" {
  name                   = "africa-mexico"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-chile" {
  name                   = "africa-chile"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-japan" {
  name                   = "africa-japan"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.5.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-korea" {
  name                   = "africa-korea"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "africa-australia" {
  name                   = "africa-australia"
  resource_group_name    = azurerm_resource_group.rg["southafricanorth"].name
  route_table_name       = azurerm_route_table.route_table["southafricanorth"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.0.4"
}
resource "azurerm_route" "chile-india" {
  name                   = "chile-india"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-sweden" {
  name                   = "chile-sweden"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-africa" {
  name                   = "chile-africa"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-mexico" {
  name                   = "chile-mexico"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.3.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-korea" {
  name                   = "chile-korea"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "chile-australia" {
  name                   = "chile-australia"
  resource_group_name    = azurerm_resource_group.rg["chilecentral"].name
  route_table_name       = azurerm_route_table.route_table["chilecentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}

resource "azurerm_route" "mexico-india" {
  name                   = "mexico-india"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-sweden" {
  name                   = "mexico-sweden"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.1.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-africa" {
  name                   = "mexico-africa"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-chile" {
  name                   = "mexico-chile"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.4.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-korea" {
  name                   = "mexico-korea"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.6.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
resource "azurerm_route" "mexico-australia" {
  name                   = "mexico-australia"
  resource_group_name    = azurerm_resource_group.rg["mexicocentral"].name
  route_table_name       = azurerm_route_table.route_table["mexicocentral"].name
  address_prefix         = "10.7.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.5.0.4"
}
