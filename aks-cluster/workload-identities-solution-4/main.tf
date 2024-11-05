resource "azurerm_user_assigned_identity" "app-team-uai" {
  location            = var.location
  name                = var.uai_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "example" {
  for_each             = { for i, x in var.role_assignments : i => x }
  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = azurerm_user_assigned_identity.app-team-uai.principal_id
}
