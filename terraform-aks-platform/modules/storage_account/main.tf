resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # FIX: Change this from allow_blob_public_access
  allow_nested_items_to_be_public = false 
  
  # Optional: Explicitly disable public network access if using Private Endpoints
  public_network_access_enabled = false 

  tags = var.tags
}

resource "azurerm_private_endpoint" "blob" {
  name                = "${var.name}-blob-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "blob"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    # Ensure this is also present if required by your policy
    is_manual_connection           = false 
  }
}