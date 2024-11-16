variable "vm_name" {
  type        = string
  description = "Virtual machine name"
}

variable "location" {
  type        = string
  description = "location"
}

variable "vm_size" {
  type        = string
  description = "default size of vm"
  default     = "Standard_DS1_v2"
}

variable "resource_group_name" {
  type        = string
  description = "name of the resource group"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet"
}
