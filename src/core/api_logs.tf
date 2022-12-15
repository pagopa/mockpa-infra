# api logs

locals {

  api_verbose_log = [
    azurerm_api_management_api.apim_node_for_psp_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1.name,
    azurerm_api_management_api.apim_node_for_io_api_v1.name,
    azurerm_api_management_api.apim_psp_for_node_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1.name,
    azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1.name,
    azurerm_api_management_api.apim_cd_info_wisp_v1.name,
    module.apim_checkout_payment_activations_api_auth_v1.name,
    module.apim_checkout_payment_activations_api_auth_v2.name,
    module.apim_checkout_payment_activations_api_v1.name,
    module.apim_nodo_per_pm_api_v1.name,
    azurerm_api_management_api.apim_api_gpd_payments_api.name,
    module.apim_api_gpd_api.name,
  ]

  api_info_log = [
    module.apim_pm_restapi_api_v4.name,
    module.apim_pm_restapirtd_api_v1.name,
    module.apim_pm_restapirtd_api_v2.name,
    module.apim_pm_auth_rtd_api_v1.name,
    module.apim_pm_auth_rtd_api_v2.name,
    module.apim_pm_restapicd_internal_api_v1.name,
    module.apim_pm_restapicd_internal_api_v2.name,
    module.apim_pm_ptg_api_v1.name,
  ]

}

# api verbose log with request/response body
resource "azurerm_api_management_api_diagnostic" "apim_logs" {
  for_each = toset(local.api_verbose_log)

  identifier               = "applicationinsights"
  resource_group_name      = azurerm_resource_group.rg_api.name
  api_management_name      = module.apim.name
  api_name                 = each.key
  api_management_logger_id = module.apim.logger_id

  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "verbose"
  http_correlation_protocol = "W3C"

  frontend_request {
    body_bytes = 8192
  }

  frontend_response {
    body_bytes = 8192
  }

  backend_request {
    body_bytes = 8192
  }

  backend_response {
    body_bytes = 8192
  }
}

# api info log without request/response body
resource "azurerm_api_management_api_diagnostic" "apim_info_logs" {
  for_each = toset(local.api_info_log)

  identifier               = "applicationinsights"
  resource_group_name      = azurerm_resource_group.rg_api.name
  api_management_name      = module.apim.name
  api_name                 = each.key
  api_management_logger_id = module.apim.logger_id

  sampling_percentage       = 100
  always_log_errors         = true
  log_client_ip             = true
  verbosity                 = "information"
  http_correlation_protocol = "W3C"

}
