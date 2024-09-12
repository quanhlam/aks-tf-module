# output "user_assigned_identities" {
#   value = {
#     for k, v in module.app-teams-uai : k => v.app-team-uai-client-id
#   }
# }

output "cluster_name" {
  value = azurerm_kubernetes_cluster.cluster.name
}

output "karpenter_uai_name" {
  value = azurerm_user_assigned_identity.karpenter-uai.name
}
