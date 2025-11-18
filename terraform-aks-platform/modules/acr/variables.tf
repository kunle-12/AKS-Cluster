variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region for ACR."
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "ACR SKU (Basic, Standard, Premium)."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Whether to enable admin user on ACR."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to ACR."
  type        = map(string)
  default     = {}
}
