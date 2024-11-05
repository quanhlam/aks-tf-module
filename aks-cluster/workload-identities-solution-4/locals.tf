locals {
  role_assignments = toset([
    for item in var.role_assignments : {
      role_name = item.role_name
      scope     = item.scope
    }
  ])
}
