output "vnet_id" {
  value = azurerm_virtual_network.aks-vnet.id
}

output "subnet_aks_system_id" {
  value = azurerm_subnet.aks_system.id
}

output "subnet_aks_nodes_id" {
  value = azurerm_subnet.aks_nodes.id
}

output "subnet_private_endpoints_id" {
  value = azurerm_subnet.private_endpoints.id
}
