variable "azure_app_name" {
  description = "name of azure application"
}

variable "azure_app_environment" {
  description = "specifies deployment environment"
}

variable "azure_app_sequential" {
  description = "specifies environment sequential number, defaults to 001"
  default     = "001"
}

variable "azure_app_location" {
  description = "location for azure app"
}

variable "azure_app_budget" {
  description = "Estimated amount of monew for azure app"
}

variable "tags" {
  description = "tags for deployed resources"
  type        = map(any)
  default     = {}
}

locals {
  location_map = {
    EUS = "East US" #with WUS
    EU2 = "East US2" #with CUS
    WUS = "West US"
    CUS = "Central US"
  }

  environment_map = {
    D = "Development"
    Q = "Quality assurance"
  }

  tags = {
    project        = var.tags.project
    appName        = var.tags.appName
    environment    = local.environment_map[var.azure_app_environment]
    pointOfContact = var.tags.pointOfContact
    deploymentDate = var.tags.deploymentDate
  }

  azure_app_rg_name            = upper(format("%s-%s-%s-%s-%s", "RSGR", var.azure_app_name, var.azure_app_environment, var.azure_app_location, var.azure_app_sequential))
  azure_app_tfstorage_name     = lower(format("%s%s%s%s%s", "stac", var.azure_app_name, var.azure_app_environment, var.azure_app_location, var.azure_app_sequential))
  azure_app_keyvault_name      = lower(format("%s%s%s%s%s", "akvt", var.azure_app_name, var.azure_app_environment, var.azure_app_location, var.azure_app_sequential))
  azure_app_log_analytics_name = upper(format("%s%s%s%s%s", "LGAN", var.azure_app_name, var.azure_app_environment, var.azure_app_location, var.azure_app_sequential))
  azure_app_budget_name        = upper(format("%s-%s-%s-%s-%s", "BUDG", var.azure_app_name, var.azure_app_environment, var.azure_app_location, var.azure_app_sequential))
  
}
