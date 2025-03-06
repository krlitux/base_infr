terraform {
  required_version = "~>1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.51.0"
    }
  }
}

provider "azurerm" {
  features {}
}
