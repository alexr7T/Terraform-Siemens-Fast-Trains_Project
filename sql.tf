resource "azurerm_mssql_server" "sql_example" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_administrator_login_name
  administrator_login_password = data.azurerm_key_vault_secret.sql_password.value
  minimum_tls_version          = var.sql_tls_version
}


resource "azurerm_mssql_database" "db_example" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.sql_example.id
  collation      = var.sql_database_collation
  sku_name       = var.sql_database_sku
  max_size_gb    = var.max_size_gb
  zone_redundant = false       
  read_scale     = false         

  lifecycle {
    prevent_destroy = true
  }
}