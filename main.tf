resource "azurerm_kubernetes_cluster" "cluster" {
  name     = local.aks_cluster_name
  location = local.resource_group_location

  resource_group_name = local.resource_group_name
  dns_prefix          = "${local.aks_cluster_name}dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

# module "workload-identities-solution-2" {
#   source = "./workload-identities"
# }

resource "azurerm_user_assigned_identity" "app-teams-uai" {
  for_each            = local.wi_json_data
  location            = local.resource_group_location
  name                = each.value.name
  resource_group_name = local.resource_group_name
}

