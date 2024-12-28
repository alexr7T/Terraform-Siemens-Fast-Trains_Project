resource "azurerm_key_vault" "kv" {
  name                        = "SiemensKeyVault"
  resource_group_name         = var.rg
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["get", "list"]
  }
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "VmAdminPassword"
  key_vault_id = azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_password" {
  name         = "SqlAdminPassword"
  key_vault_id = azurerm_key_vault.kv.id
}