resource "azurerm_resource_group" "azure_app" {
  name     = local.azure_app_rg_name
  location = local.location_map[var.azure_app_location]
  tags     = local.tags
}

resource "azurerm_storage_account" "azure_app" {
  name                = local.azure_app_tfstorage_name
  resource_group_name = azurerm_resource_group.azure_app.name

  location                 = azurerm_resource_group.azure_app.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "azure_app" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.azure_app.name
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "azure_app" {
  name                        = local.azure_app_keyvault_name
  location                    = azurerm_resource_group.azure_app.location
  resource_group_name         = azurerm_resource_group.azure_app.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  tags     = local.tags

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get", "Set", "List"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_log_analytics_workspace" "azure_app" {
  name                = local.azure_app_log_analytics_name
  location            = azurerm_resource_group.azure_app.location
  resource_group_name = azurerm_resource_group.azure_app.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_consumption_budget_resource_group" "azure_app" {
  name              = local.azure_app_budget_name
  resource_group_id = azurerm_resource_group.azure_app.id

  amount     = var.azure_app_budget
  time_grain = "Monthly"

  time_period {
    start_date = "2024-08-01T00:00:00Z"
    end_date   = "2026-01-01T00:00:00Z"
  }

  notification {
    enabled   = true
    threshold = 90.0
    operator  = "GreaterThan"

    contact_emails = [
      "ext-cgratelli@analytics.pe",
    ]
  }
}
