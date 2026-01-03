variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "dns_prefix" { type = string }

variable "kubernetes_version" { type = string }

variable "system_node_subnet_id" { type = string }
variable "system_node_count" { type = number }
variable "system_node_vm_size" { type = string }

variable "user_node_pool_enabled" { type = bool }
variable "user_node_subnet_id" { type = string }
variable "user_node_count" { type = number }
variable "user_node_vm_size" { type = string }

variable "sku_tier" {
  description = "AKS SKU tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "support_plan" {
  description = "Specifies the support plan for the AKS cluster. Possible values are KubernetesOfficial and AKSLongTermSupport."
  type        = string
  default     = "KubernetesOfficial"
}


variable "tags" {
  type    = map(string)
  default = {}
}
