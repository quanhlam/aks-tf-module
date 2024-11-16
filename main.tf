

resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = var.location
}

resource "azurerm_resource_group" "rg2" {
  name     = "rg2"
  location = var.location
}

module "cluster_primary" {
  source              = "./modules/aks-cluster"
  resource_group_name = azurerm_resource_group.rg1.name
  name_prefix         = "primary"
  location            = var.location
  vm_size             = var.vm_size
  enable_karpenter    = true
}

module "cluster_secondary" {
  source              = "./modules/aks-cluster"
  resource_group_name = azurerm_resource_group.rg1.name
  name_prefix         = "secondary"
  location            = var.location
  vm_size             = var.vm_size
  enable_karpenter    = false
}
