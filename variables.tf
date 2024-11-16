
variable "location" {
  type        = string
  description = "location"
}

variable "vm_size" {
  type        = string
  description = "default size of vm"
}

variable "enable_karpenter" {
  type    = bool
  default = false
}
