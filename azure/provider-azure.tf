terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.67.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "rg_prod" {
    name     = "rg-criminix-prod"
    location = "East US"
    
    tags = {
        "environment" = "prod"
    }
}
