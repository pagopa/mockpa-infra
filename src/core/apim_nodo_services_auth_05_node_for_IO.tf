######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api_auth = {
    display_name          = "Node for IO WS (AUTH)"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo-auth/node-for-io"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api_auth" {
  name                = format("%s-nodo-for-io-api-auth", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_node_for_io_api_auth.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1_auth" {
  name                  = format("%s-node-for-io-api-auth", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_io_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api_auth.id
  version               = "v1"
  service_url           = local.apim_node_for_io_api_auth.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api_auth.description
  display_name = local.apim_node_for_io_api_auth.display_name
  path         = local.apim_node_for_io_api_auth.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/auth/nodeForIO.wsdl")
    wsdl_selector {
      service_name  = "nodeForIO_Service"
      endpoint_name = "nodeForIO_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy_auth" {
  api_name            = azurerm_api_management_api.apim_node_for_io_api_v1_auth.name
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_auth_decoupler_enable
  })

}
