resource "azurerm_resource_group" "exp" {
  name     = var.resource_name
  location = var.location
}


# resource "azurerm_storage_account" "test03" {
#   name                     = var.storage_name
#   resource_group_name      = azurerm_resource_group.exp.name
#   location                 = azurerm_resource_group.exp.location
#   account_tier             = var.account_tier
#   account_replication_type = var.account_replication_type

# }
