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
