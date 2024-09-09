output "user_assigned_identities" {
  value = {
    for k, v in module.app-teams-uai : k => v.app-team-uai-client-id
  }
}
