variable "location" {
  type        = string
  description = "Azure region"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

# variable "acr_name" {
#   type        = string
#   description = "ACR name"
# }

variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
}

variable "storage_name" {
  type        = string
  description = "Storage account name"
}
