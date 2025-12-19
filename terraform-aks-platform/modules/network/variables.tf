variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_aks_system_cidr" {
  type = string
}

variable "subnet_aks_nodes_cidr" {
  type = string
}

variable "subnet_private_endpoints_cidr" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
