resource "azurerm_resource_group" "exp" {
  name     = var.resource_name
  location = var.location
}

resource "azurerm_storage_account" "test03" {
  name                     = var.storage_name
  resource_group_name      = var.resource_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

}
