output "id" {
  description = "ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "name" {
  description = "Name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "kube_config" {
  description = "User kubeconfig to connect to the AKS cluster."
  value = {
    host                   = azurerm_kubernetes_cluster.this.kube_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.this.kube_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
    username               = azurerm_kubernetes_cluster.this.kube_config[0].username
    password               = azurerm_kubernetes_cluster.this.kube_config[0].password
  }
  sensitive = true
}

output "kube_admin_config" {
  description = "Admin kubeconfig to connect to the AKS cluster."
  value = {
    host                   = azurerm_kubernetes_cluster.this.kube_admin_config[0].host
    client_certificate     = azurerm_kubernetes_cluster.this.kube_admin_config[0].client_certificate
    client_key             = azurerm_kubernetes_cluster.this.kube_admin_config[0].client_key
    cluster_ca_certificate = azurerm_kubernetes_cluster.this.kube_admin_config[0].cluster_ca_certificate
    username               = azurerm_kubernetes_cluster.this.kube_admin_config[0].username
    password               = azurerm_kubernetes_cluster.this.kube_admin_config[0].password
  }
  sensitive = true
}

output "node_resource_group" {
  description = "Resource group containing AKS nodes and managed resources."
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "identity" {
  description = "System-assigned identity for the AKS cluster."
  value       = azurerm_kubernetes_cluster.this.identity
}
