output "user_assigned_identities" {
  value = {
    for k, v in azurerm_user_assigned_identity.app-teams-uai : k => v.client_id
  }
}
