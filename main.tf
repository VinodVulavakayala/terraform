provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "aks-rg" {

    name = var.rgname
    location= var.location
  
}

module "keyvault" {
 source = "./modules/keyvault"
 kv_name = var.kv_name
 rgname = var.rgname
 location = var.location
 
 depends_on = [ azurerm_resource_group.aks-rg ]

}

module "spn" {
  source = "./modules/spn"
  app_displayname = var.app_displayname
  spn_name = var.spn_name
  
}

/*
  resource "azurerm_key_vault_secret" "aksapp" {
  name         = var.spn_name
  value        = module.spn.spn_secret_value
  key_vault_id = module.keyvault.keyvault_id

  depends_on = [ module.spn ]
}
*/

#create Azure Kubernetes Service
module "aks" {
  source                 = "./modules/aks/"
  service_principal_name = var.spn_name
  client_id              = module.spn.spn_client_id
  client_secret          = module.spn.spn_secret_value
  location               = var.location
  resource_group_name    = var.rgname

  depends_on = [
    module.spn
  ]

}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}