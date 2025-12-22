locals {
  env         = "prod"
  name_prefix = "aksplat-prod"

  tags = {
    environment = local.env
    project     = "aks-platform"
  }
}

module "rg" {
  source   = "../../modules/resource_group"
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.tags
}

module "networking" {
  source              = "../../modules/network"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.rg.name

  address_space                 = ["10.20.0.0/16"]
  subnet_aks_system_cidr        = "10.20.1.0/24"
  subnet_aks_nodes_cidr         = "10.20.2.0/23"
  subnet_private_endpoints_cidr = "10.20.10.0/24"

  tags = local.tags
}

module "acr" {
  source              = "../../modules/acr"
  name                = var.acr_name
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.tags
}

module "key_vault" {
  source                     = "../../modules/key_vault"
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = module.rg.name
  tenant_id                  = var.tenant_id
  private_endpoint_subnet_id = module.networking.subnet_private_endpoints_id
  tags                       = local.tags
}

module "storage" {
  source                     = "../../modules/storage_account"
  name                       = var.storage_name
  location                   = var.location
  resource_group_name        = module.rg.name
  private_endpoint_subnet_id = module.networking.subnet_private_endpoints_id
  tags                       = local.tags
}

module "dns" {
  source              = "../../modules/dns_private_zones"
  resource_group_name = module.rg.name
  vnet_id             = module.networking.vnet_id
  tags                = local.tags
}

module "aks" {
  source                     = "../../modules/aks"
  name                       = "${local.name_prefix}-aks"
  location                   = var.location
  resource_group_name        = module.rg.name
  dns_prefix                 = "aksplatprod"

  kubernetes_version         = "1.30.3"

  system_node_subnet_id      = module.networking.subnet_aks_system_id
  system_node_count          = 3
  system_node_vm_size        = "Standard_DS3_v2"

  user_node_pool_enabled     = true
  user_node_subnet_id        = module.networking.subnet_aks_nodes_id
  user_node_count            = 5
  user_node_vm_size          = "Standard_DS3_v2"

  tags = local.tags
}

module "acr_pull" {
  source           = "../../modules/acr"
  name             = var.acr_name
  location         = var.location
  resource_group_name = module.rg.name
  aks_principal_id = module.aks.kubelet_identity_object_id
  tags             = local.tags
}
