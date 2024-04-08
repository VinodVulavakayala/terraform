output "spn_secret_value" {
 value = azuread_service_principal_password.aksapp.value
}

output "spn_client_id" {

    value = azuread_application.aksapp.client_id
  
}