resource "azurerm_kubernetes_cluster" "cluster" {
  name     = local.aks_cluster_name
  location = local.resource_group_location

  resource_group_name = local.resource_group_name
  dns_prefix          = "${local.aks_cluster_name}dns"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}


resource "azurerm_user_assigned_identity" "karpenter-uai" {
  count               = var.enable_karpenter == true ? 1 : 0
  location            = local.resource_group_location
  name                = "karpenter-uai-${local.aks_cluster_name}"
  resource_group_name = local.resource_group_name
}

resource "azurerm_federated_identity_credential" "karpenter-uai-fid" {
  count               = var.enable_karpenter == true ? 1 : 0
  name                = "fid-${local.aks_cluster_name}"
  resource_group_name = local.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.karpenter-uai[0].id
  subject             = "system:serviceaccount:${local.karpenter_namespace}:${local.karpenter_sa}"
}

# resource "azurerm_role_assignment" "_" {
#   depends_on           = [azurerm_user_assigned_identity.karpenter-uai]
#   for_each             = local.karpenter_roles
#   scope                = azurerm_kubernetes_cluster.cluster.node_resource_group_id
#   role_definition_name = each.value
#   principal_id         = azurerm_user_assigned_identity.karpenter-uai[0].principal_id
# }

# module "workload-identities-solution-2" {
#   source = "./workload-identities"
# }

# module "app-teams-uai" {
#   source              = "./workload-identities-solution-4"
#   for_each            = local.wi_json_data
#   location            = local.resource_group_location
#   uai_name            = each.value.name
#   resource_group_name = local.resource_group_name
#   role_assignments = [
#     for item in each.value.role_assignments : {
#       role_name = item.role_name
#       scope     = item.scope
#     }
#   ]
#   # role_assignments = each.value.role_assignments
# }
