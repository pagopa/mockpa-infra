######################
## WS nodo per PA ##
######################
locals {
  apim_nodo_per_pa_api_auth = {
    display_name          = "Nodo per PA WS (AUTH)"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo-auth/nodo-per-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_auth" {
  name                = format("%s-nodo-per-pa-api-auth", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_nodo_per_pa_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_auth" {
  name                  = format("%s-nodo-per-pa-api-auth", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pa_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api_auth.id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api_auth.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api_auth.description
  display_name = local.apim_nodo_per_pa_api_auth.display_name
  path         = local.apim_nodo_per_pa_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/auth/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy_auth" {
  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })
}

# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_api_auth_v1_policy" {
  count               = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = var.env_short == "d" ? "6352c3bcc257810f183b3984" : var.env_short == "u" ? "63e5237639519a0f7094b47e" : "63e5237639519a0f7094b47e"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml")
}

# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_api_auth_v1_policy" {
  count               = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = var.env_short == "d" ? "6352c3bcc257810f183b3985" : var.env_short == "u" ? "63e5237639519a0f7094b47f" : "63e5237639519a0f7094b47f"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml")
}
