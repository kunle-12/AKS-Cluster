# resource "azurerm_container_registry" "acr" {
#   name                = var.name
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   sku                 = var.sku
#   admin_enabled       = false
#   tags                = var.tags
# }

# # Use a data source or a static variable that is known before apply
# resource "azurerm_role_assignment" "aks_pull" {
#   # Remove the conditional count if possible, 
#   # or ensure aks_principal_id is not coming directly from a resource output
#   scope                = azurerm_container_registry.acr.id
#   role_definition_name = "AcrPull"
#   principal_id         = var.aks_principal_id
# }
