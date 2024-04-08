resource "azuread_application" "aksapp" {
  display_name = var.app_displayname
}

resource "azuread_service_principal" "aksapp" {
  client_id  = azuread_application.aksapp.client_id
}

resource "azuread_service_principal_password" "aksapp" {
  service_principal_id = azuread_service_principal.aksapp.object_id
}
