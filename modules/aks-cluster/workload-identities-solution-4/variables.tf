
variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "uai_name" {
  type = string
}

variable "role_assignments" {
  type = list(object({
    scope     = string
    role_name = string
  }))
}
