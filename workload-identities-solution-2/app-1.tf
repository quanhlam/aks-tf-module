resource "azurerm_user_assigned_identity" "app-team-1-uai" {
  location            = local.resource_group_location
  name                = "app-team-1-uai"
  resource_group_name = local.resource_group_name
}

resource "azurerm_federated_identity_credential" "example" {
  name                = "example"
  resource_group_name = local.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://foo"
  parent_id           = azurerm_user_assigned_identity.app-team-1-uai.id
  subject             = "foo"
}

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.app-team-1-uai.principal_id
}
