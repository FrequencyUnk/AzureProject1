provider "azurerm" {

    features {}

}

 

provider "azurerm" {

    alias           = "target"

    subscription_id = var.sub

}

 

resource "azurerm_resource_group" "rg" {

  provider = "azurerm.target"

  name     = "terraform_${var.env}_rg"

  location = var.location

}

 

resource "azurerm_storage_account" "sa" {

  provider = "azurerm.target"

  name                     = "${var.env_abbr}tf${var.name}"

  resource_group_name      = azurerm_resource_group.rg.name

  location                 = azurerm_resource_group.rg.location

  account_kind             = "StorageV2"

  account_tier             = "Standard"

  account_replication_type = "LRS"

}

 

resource "azurerm_storage_container" "state" {

  provider = "azurerm.target"

  name                  = "${var.name}_terraform_state"

  storage_account_name  = azurerm_storage_account.sa.name

  container_access_type = "private"

}
