resource "azurerm_virtual_network" "aks-vnet" {
  name                = "${var.name_prefix}-vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "aks_system" {
  name                 = "${var.name_prefix}-snet-aks-system"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = [var.subnet_aks_system_cidr]
}

resource "azurerm_subnet" "aks_nodes" {
  name                 = "${var.name_prefix}-snet-aks-nodes"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = [var.subnet_aks_nodes_cidr]
}

resource "azurerm_subnet" "private_endpoints" {
  name                 = "${var.name_prefix}-snet-private-endpoints"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.aks-vnet.name
  address_prefixes     = [var.subnet_private_endpoints_cidr]
}
