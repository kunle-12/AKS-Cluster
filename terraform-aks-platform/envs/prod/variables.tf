variable "rg_name" {
  description = "Name of the resource group for the AKS platform (dev)."
  type        = string
}

variable "location" {
  description = "Azure region for dev environment."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = <<EOT
Map of subnets to create in the VNet.

Example:
{
  aks       = { address_prefixes = ["10.20.1.0/24"] }
  bastion   = { address_prefixes = ["10.20.2.0/27"] }
  firewall  = { address_prefixes = ["10.20.3.0/26"] }  # optional
  private_ep = { address_prefixes = ["10.20.4.0/26"] } # optional
}
EOT
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "aks_subnet_name" {
  description = "Key in the subnets map that corresponds to the AKS subnet."
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry for dev."
  type        = string
}

variable "aks_name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS API server."
  type        = string
}

variable "kubernetes_version" {
  description = "Desired Kubernetes version for AKS. If null, Azure picks a default."
  type        = string
  default     = null
}

variable "aks_node_resource_group" {
  description = "Name of the resource group for AKS nodes and managed resources. If null, Azure will generate one."
  type        = string
  default     = null
}

variable "system_node_count" {
  description = "Number of nodes in the system node pool."
  type        = number
  default     = 2
}

variable "system_node_vm_size" {
  description = "VM size for the system node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
