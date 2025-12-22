data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name                    = "standard"
  rbac_authorization_enabled = true
  public_network_access_enabled = false
  purge_protection_enabled    = true
  soft_delete_retention_days  = 7
  tags                        = var.tags
}

resource "azurerm_private_endpoint" "this" {
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
  name                           = "${var.name}-conn"
  private_connection_resource_id = azurerm_key_vault.this.id
  subresource_names              = ["vault"]
  is_manual_connection           = false
}

