resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  sku_tier            = var.sku_tier

  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = var.system_node_vm_size
    vnet_subnet_id      = var.vnet_subnet_id
    type                = "VirtualMachineScaleSets"
    orchestrator_version = var.kubernetes_version
    os_disk_size_gb     = 128
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
  }

  api_server_access_profile {
    private_cluster_enabled = var.private_cluster_enabled
  }

  role_based_access_control_enabled = true

  tags = var.tags
}

# Give AKS permission to pull from ACR
data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.identity[0].principal_id

  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
}
