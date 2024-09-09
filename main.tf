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

module "app-teams-uai" {
  source              = "./workload-identities-solution-4"
  for_each            = local.wi_json_data
  location            = local.resource_group_location
  uai_name            = each.value.name
  resource_group_name = local.resource_group_name
  role_assignments = [
    for item in each.value.role_assignments : {
      role_name = item.role_name
      scope     = item.scope
    }
  ]
  # role_assignments = each.value.role_assignments
}
