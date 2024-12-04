resource "azurerm_resource_group" "st" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_storage_account" "st" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.st.name
  location                 = azurerm_resource_group.st.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  min_tls_version = "TLS1_2"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_container" "st" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "private"
}