data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-rx" {
  name                = "${var.prefix}-biz-evt-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-biz-evt-enrich_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-biz-evt-enrich"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-negative-biz-evt_pagopa-negative-biz-evt-rx" {
  name                = "${var.prefix}-negative-biz-evt-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-negative-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-negative-awakable-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-negative-awakable-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-negative-final-biz-evt_pagopa-biz-evt-tx" {
  name                = "${var.prefix}-biz-evt-tx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-negative-final-biz-evt"
  resource_group_name = "${local.product}-msg-rg"
}

