variable "location" {
  type        = string
}

variable "acr_name" {
  type        = string
}

variable "key_vault_name" {
  type        = string
}

variable "storage_name" {
  type        = string
}
variable "tenant_id" {
  description = "The Azure Active Directory tenant ID"
  type        = string
}