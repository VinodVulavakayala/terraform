data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "azure_kv" {
  name                        = var.kv_name
  location                    = var.location
  resource_group_name         = var.rgname
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}