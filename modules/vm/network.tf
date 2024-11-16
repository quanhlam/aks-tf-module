resource "azurerm_public_ip" "node-public-ip" {
  name                    = "${var.vm_name}-ip"
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30

  tags = {
    product_id = "15336"
  }
}

resource "azurerm_network_interface" "node-nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.node-public-ip.id
  }

  tags = {
    "product_id" = "15336"
  }
}
