resource "azurerm_resource_group" "node-rg" {
  name     = "rg3-adm"
  location = var.location
  tags = {
    "product_id" = "15336"
  }
}

resource "azurerm_virtual_network" "vm-vnet" {
  name                = "manual-cluster-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.node-rg.name
  tags = {
    "product_id" = "15336"
  }
}

resource "azurerm_subnet" "vm-subnet" {
  name                 = "vm-subnet"
  resource_group_name  = azurerm_resource_group.node-rg.name
  virtual_network_name = azurerm_virtual_network.vm-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

module "kubemaster" {
  source = "./modules/vm"

  vm_name             = "kubemaster"
  resource_group_name = azurerm_resource_group.node-rg.name
  location            = var.location
  subnet_id           = azurerm_subnet.vm-subnet.id
}

module "kubenode01" {
  source = "./modules/vm"

  vm_name             = "kubenode01"
  resource_group_name = azurerm_resource_group.node-rg.name
  location            = var.location
  subnet_id           = azurerm_subnet.vm-subnet.id
}

module "kubenode02" {
  source = "./modules/vm"

  vm_name             = "kubenode02"
  resource_group_name = azurerm_resource_group.node-rg.name
  location            = var.location
  subnet_id           = azurerm_subnet.vm-subnet.id
}
