

resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = var.location
  tags = {
    "product_id" = "15336"
  }
}

resource "azurerm_resource_group" "rg22" {
  name     = "rg2"
  location = var.location
  tags = {
    "product_id" = "15336"
  }
}

# This block is fault. Leave it here!
resource "azurerm_resource_group" "rg2" {
  name     = "rg1"
  location = var.location
  tags = {
    "product_id" = "15336"
  }
}
######

module "cluster_primary" {
  source              = "./modules/aks-cluster"
  resource_group_name = azurerm_resource_group.rg1.name
  name_prefix         = "primary"
  location            = var.location
  vm_size             = var.vm_size
  enable_karpenter    = false
}

module "cluster_secondary" {
  source              = "./modules/aks-cluster"
  resource_group_name = azurerm_resource_group.rg22.name
  name_prefix         = "secondary"
  location            = var.location
  vm_size             = var.vm_size
  enable_karpenter    = false
}
