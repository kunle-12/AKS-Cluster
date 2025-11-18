variable "resource_group_name" {
  description = "Name of the resource group containing AKS."
  type        = string
}

variable "location" {
  description = "Azure region for AKS."
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS API server."
  type        = string
}

variable "kubernetes_version" {
  description = "AKS Kubernetes version (optional)."
  type        = string
  default     = null
}

variable "node_resource_group" {
  description = "Resource group for AKS nodes (optional, let Azure generate if null)."
  type        = string
  default     = null
}

variable "system_node_count" {
  description = "Number of nodes in the system node pool."
  type        = number
  default     = 2
}

variable "system_node_vm_size" {
  description = "VM size for system node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "vnet_subnet_id" {
  description = "Subnet ID for AKS nodes."
  type        = string
}

variable "private_cluster_enabled" {
  description = "Whether to enable private AKS API server."
  type        = bool
  default     = true
}

variable "aci_connector_enabled" {
  description = "Enable ACI connector (not recommended in most cases)."
  type        = bool
  default     = false
}

variable "acr_id" {
  description = "ID of the Azure Container Registry to grant pull access to."
  type        = string
}

variable "sku_tier" {
  description = "AKS SKU tier (Free or Standard)."
  type        = string
  default     = "Free"
}

variable "network_plugin" {
  description = "Network plugin (azure or kubenet)."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy (azure or calico)."
  type        = string
  default     = "azure"
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR."
  type        = string
  default     = "172.17.0.1/16"
}

variable "service_cidr" {
  description = "Kubernetes service CIDR."
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the service CIDR for the DNS service."
  type        = string
  default     = "10.0.0.10"
}

variable "tags" {
  description = "Tags to apply to AKS."
  type        = map(string)
  default     = {}
}
