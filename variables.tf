variable "resource_group_name" {
  description = "Name of the resource group the virtual network will be created in"
  type = string
}

variable "network_info" {
  description = "Variable MAP of the required network information"
}

variable "hubvnet_id" {
  description = "Hub vnet ID required for spoke vnets"
  type = string
  default = ""
}

variable "hubvnet_name" {
  description = "Hub vnet name required for spoke vnets"
  type = string
  default = ""
}

variable "hubvnet_rg" {
  description = "Hub vnet resource group required when hub vnet is in different subscription"
  type = string
  default = ""
}

variable "tags" {
  description = "Map of tags needed for the resouces"
  type = map
  default     = null
}