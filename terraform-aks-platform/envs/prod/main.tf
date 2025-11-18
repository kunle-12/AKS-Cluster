terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev"
    storage_account_name = "sttfstatedev123"
    container_name       = "tfstate"
    key                  = "aks-dev.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# After AKS is created we use its kube_admin_config to configure
# Kubernetes and Helm providers.
provider "kubernetes" {
  host                   = module.aks.kube_admin_config.host
  client_certificate     = base64decode(module.aks.kube_admin_config.client_certificate)
  client_key             = base64decode(module.aks.kube_admin_config.client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_admin_config.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_admin_config.host
    client_certificate     = base64decode(module.aks.kube_admin_config.client_certificate)
    client_key             = base64decode(module.aks.kube_admin_config.client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_admin_config.cluster_ca_certificate)
  }
}

module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vnet_name           = var.vnet_name
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  aks_subnet_name     = var.aks_subnet_name
  tags                = var.tags
}

module "acr" {
  source              = "../../modules/acr"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  acr_name            = var.acr_name
  sku                 = "Standard"
  admin_enabled       = false
  tags                = var.tags
}

module "aks" {
  source              = "../../modules/aks"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  cluster_name        = var.aks_name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.aks_node_resource_group
  system_node_count   = var.system_node_count
  system_node_vm_size = var.system_node_vm_size
  vnet_subnet_id      = module.network.aks_subnet_id
  private_cluster_enabled = true
  acr_id              = module.acr.id
  tags                = var.tags
}

module "argocd" {
  source           = "../../modules/argocd_bootstrap"
  namespace        = "argocd"
  create_namespace = true
  # values = [file("${path.module}/argocd-values-dev.yaml")] # optional
}
