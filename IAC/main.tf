resource "random_id" "storage_account_name_unique" {
  byte_length = 8
}

# Criar um Azure Data Lake Storage Gen2
resource "azurerm_storage_account" "storage" {
  name                     = "datalake${random_id.storage_account_name_unique.hex}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
}

# Criar quatro containers dentro do Azure Data Lake Storage Gen2: Landing-zone, Bronze, Silver e Gold
resource "azurerm_storage_container" "landing-zone" {
  name                  = "landing-zone"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
  depends_on            = [azurerm_storage_account.storage]
}


resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
  depends_on            = [azurerm_storage_account.storage]
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
  depends_on            = [azurerm_storage_account.storage]
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "container"
  depends_on            = [azurerm_storage_account.storage]
}

# Criar um Azure SQL Server
resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sql${random_id.storage_account_name_unique.hex}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "AdminProjetoFinal"
  administrator_login_password = "ProjetoFinal2024!"

}