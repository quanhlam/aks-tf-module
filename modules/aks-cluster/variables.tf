variable "name_prefix" {
  type        = string
  description = "name_prefix"
}

variable "location" {
  type        = string
  description = "location"
}

variable "vm_size" {
  type        = string
  description = "default size of vm"
}

variable "resource_group_name" {
  type        = string
  description = "name of the resource group"
}

variable "enable_karpenter" {
  type    = bool
  default = false
}
