output "id" {
  description = "ID of the ACR."
  value       = azurerm_container_registry.acr.id
}

output "name" {
  description = "Name of the ACR."
  value       = azurerm_container_registry.acr.name
}

output "login_server" {
  description = "Login server of the ACR."
  value       = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  description = "Admin username for ACR (if enabled)."
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "admin_password" {
  description = "Admin password for ACR (if enabled)."
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}
