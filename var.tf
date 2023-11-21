variable "resource_name" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type    = string
  default = "example_resources"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type    = string
  default = "westus2"
}

variable "storage_name" {
  description = "storage account name"
  type = any
  default = "storage"
  
}

variable "account_tier" {
    type = string
    description = "value"
    default = "Standard"
  
}

variable "account_replication_type" {
    type = string
    description = ""
    default = "LRS"
}

variable "environment" {
  type = string
  default = "staging"
  
}

