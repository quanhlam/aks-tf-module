resource "azurerm_user_assigned_identity" "app-team-2-uai" {
  location            = local.resource_group_location
  name                = "app-team-2-uai"
  resource_group_name = local.resource_group_name
}
