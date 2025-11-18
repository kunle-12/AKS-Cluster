variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for the network resources."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = <<EOT
Map of subnets to create.
Example:
{
  aks     = { address_prefixes = ["10.0.1.0/24"] }
  bastion = { address_prefixes = ["10.0.2.0/24"] }
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

variable "tags" {
  description = "Tags to apply to network resources."
  type        = map(string)
  default     = {}
}
