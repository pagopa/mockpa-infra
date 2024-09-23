### EVH
data "azurerm_eventhub_authorization_rule" "payment_options_re_authorization_rule" {
  name                = "${local.project_short}-payment-options-re-rx"
  resource_group_name = "${local.project}-evh-rg"
  eventhub_name       = "pagopa-payopt-evh"
  namespace_name      = "${local.project}-evh"
}

data "azurerm_eventhub_authorization_rule" "pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_cache_sync_rx" {
  name                = "nodo-dei-pagamenti-cache-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_verify_ko" {
  name                = "nodo-dei-pagamenti-verify-ko-tx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns03"
  eventhub_name       = "nodo-dei-pagamenti-verify-ko"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "apim_api_config_product" {
  product_id          = "product-api-config-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
