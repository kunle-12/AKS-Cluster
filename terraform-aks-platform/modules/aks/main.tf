resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  dynamic "support_plan" {
    for_each = var.support_plan == null ? [] : [1]
    content {
      name = var.support_plan
    }
  }


  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "system"
    vm_size        = var.system_node_vm_size
    node_count     = var.system_node_count
    vnet_subnet_id = var.system_node_subnet_id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  count                = var.user_node_pool_enabled ? 1 : 0
  name                 = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size              = var.user_node_vm_size
  node_count           = var.user_node_count
  vnet_subnet_id       = var.user_node_subnet_id
}
