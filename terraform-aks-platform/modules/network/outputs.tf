output "vnet_id" {
  description = "ID of the virtual network."
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet IDs keyed by subnet name."
  value = {
    for k, s in azurerm_subnet.this : k => s.id
  }
}

output "aks_subnet_id" {
  description = "Subnet ID for the AKS subnet."
  value       = azurerm_subnet.this[var.aks_subnet_name].id
}
