## Azure provider details has to be mentioned bellow

terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~>2.0"
        }
    }
}
provider "azurerm" {
    features{}
    subscription_id = "2ddb36a4-7b9f-48f2-871c-fd97bbcaecf5"
    client_id = "f78b894c-e248-4fcd-8132-115eaf10d4e6"
    tenant_id = "b24fbfdb-291b-4470-8402-da7d741c68e4"
}