resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-wisp-converter-availability" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-wisp-converter-availability"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id]
    email_subject          = "Alert pagopa-wisp-converter-availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for https://api.platform.pagopa.it/wisp-converter/ is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-wisp-converter"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s startswith "https://api.platform.pagopa.it/wisp-converter/"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

// These API invoking and result are logged only on application insight
// [receiptKo, receiptOk, createTimer, deleteTimer]
resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-wisp-converter-ai-availability" {
  for_each = var.env_short == "p" ? toset(["receiptKo", "receiptOk", "createTimer", "deleteTimer"]) : []

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-wisp-converter-${each.value}-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Alert pagopa-wisp-converter-${each.value}-availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability for wisp-converter API ${each.value} is less than or equal to 99% - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-wisp-converter https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/0287abc9-da26-40fa-b261-f1634ee649aa"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
traces
| where cloud_RoleName == "pagopawispconverter"
| summarize
    Total=count(message startswith "Invoking API operation ${each.value}"),
    Failed=count(message startswith "Failed API operation ${each.value}")
    by bin(timestamp, 5m)
| where Total > 0
| extend availability=toreal(Total-Failed) / Total
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-wisp-converter-ai-error" {
  for_each = var.env_short == "p" ? toset(["receiptKo", "receiptOk", "createTimer", "deleteTimer"]) : []

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-wisp-converter-${each.value}-error"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Alert pagopa-wisp-converter-${each.value}-error"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Errors for wisp-converter API ${each.value} is greater than 1 - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/pagopa-p-opex_pagopa-wisp-converter https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/0287abc9-da26-40fa-b261-f1634ee649aa"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
traces
| where cloud_RoleName == "pagopawispconverter"
| where message startswith "Failed API operation ${each.value}"
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-wisp-converter-wic-error" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-wisp-converter-wic-error"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Alert pagopa-wisp-converter-wic}-error"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Errors for wisp-converter API WIC-<ERROR> is greater than 1 - https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/0287abc9-da26-40fa-b261-f1634ee649aa"
  enabled        = true
  query = (<<-QUERY
traces
| where cloud_RoleName == "pagopawispconverter"
| where message contains "WIC-" 
| extend problem_detail=extract('ProblemDetail\\[(.+)\\]', 1, message)
| extend error_status=extract('status=([0-9]+)\\,', 1, problem_detail)
| extend error_code=extract("type='https://pagopa.gov/error-code/(WIC-[0-9]+)'", 1, problem_detail)
| extend error_detail=extract("detail='(.+)'", 1, problem_detail)
| where  error_code !startswith "WIC-3"
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

