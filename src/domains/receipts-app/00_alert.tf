
locals {

  fn_name_for_alerts_exceptions = var.env_short == "d" ? [] : [
    {
      name : "BizEventToReceiptProcessor"
    }
  ]


  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]

  # ENABLE PROD afert deploy 
  # action_groups = var.env_short == "p" ? concat(local.action_groups_default,data.azurerm_monitor_action_group.opsgenie[0].id) : local.action_groups_default
  action_groups = local.action_groups_default
}

###########################################
# On exceptions                           #
###########################################

## Alert
# This alert cover the following error case:
# 1. BizEventToReceiptProcessor throws an exception for the function execution (CosmosDB related errors)
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-sending-receipt-error-alert" {
  for_each = { for c in local.fn_name_for_alerts_exceptions : c.name => c }

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-in-poison-queue-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipts] error on initial saving receipt to Cosmos"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Binding exception for function BizEventToReceiptProcessor"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "Exception while executing function: Functions.${each.value.name}"
    | order by timestamp desc
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

}

###########################################
# On traces                               #
###########################################

## Alert
# This alert cover the following error case:
# 1. BizEventToReceiptProcessor execution logs that a Receipt instance has been set to NOT_QUEUE_SENT
# https://github.com/pagopa/pagopa-receipt-pdf-datastore/blob/1a0b36f9693c17ceeffe5d35bf7ace7371a72a13/src/main/java/it/gov/pagopa/receipt/pdf/datastore/service/BizEventToReceiptService.java#L58C17-L58C28
#
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-datastore-not-sent-to-queue-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receiptsdatastore-not-sent-to-queue-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id] # future need add opsgenie hook
    email_subject          = "[Receipt] queue insertion error"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Receipt unable to be sent to process queue"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "Error sending message to queue"
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME https://github.com/pagopa/pagopa-receipt-pdf-datastore/blob/1a0b36f9693c17ceeffe5d35bf7ace7371a72a13/helm/values-prod.yaml#L81C25-L81C50
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Alert
# This alert cover the following error case:
# 1. ManageReceiptPoisonQueueProcessor execution logs that a new entry has been set in error
# https://github.com/pagopa/pagopa-receipt-pdf-generator/blob/6b6c600db4b13ad7cd4b64596ba29fd0f6c38e70/src/main/java/it/gov/pagopa/receipt/pdf/generator/ManageReceiptPoisonQueue.java#L105
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-in-error-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-in-error-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipt] entry in error to review"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "ManageReceiptPoisonQueueProcessor saving new error in collection to review"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "saving new entry to the retry error to review"
  QUERY
    , "pagopareceiptpdfgenerator" # from HELM's parameter WEBSITE_SITE_NAME https://github.com/pagopa/pagopa-receipt-pdf-generator/blob/6b6c600db4b13ad7cd4b64596ba29fd0f6c38e70/helm/values-prod.yaml#L81C25-L81C50
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}



## Alert
# This alert cover the following case:
# 1. BizEventToReceiptProcessor receive a biz event related to a cart (totalNotice > 1)
# https://github.com/pagopa/pagopa-receipt-pdf-datastore/blob/1a0b36f9693c17ceeffe5d35bf7ace7371a72a13/src/main/java/it/gov/pagopa/receipt/pdf/datastore/BizEventToReceipt.java#L160
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-cart-event-discarded-alert" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-receipt-cart-event-discarded-alert"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Receipts] biz event related to a cart"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "BizEventToReceiptProcessor received a biz event related to a cart (totalNotice > 1), the event has been discarded"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | where message contains "discarded because is part of a payment cart"
    | order by timestamp desc
  QUERY
    , "pagopareceiptpdfdatastore" # from HELM's parameter WEBSITE_SITE_NAME https://github.com/pagopa/pagopa-receipt-pdf-datastore/blob/1a0b36f9693c17ceeffe5d35bf7ace7371a72a13/helm/values-prod.yaml#L81
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Alert
# This alert cover the following error case:
# 1. NotifierRetry execution logs that a new entry has been set in error
# https://github.com/pagopa/pagopa-receipt-pdf-notifier/blob/26067525b154796962168e661ee932d4e628f1be/src/main/java/it/gov/pagopa/receipt/pdf/notifier/NotifierRetry.java#L52
resource "azurerm_monitor_scheduled_query_rules_alert" "receipts-to-notify-in-retry-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-notify-in-error-retry"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "NotifierRetry function called"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Retry on notification to IO error for a receipt"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "[NotifierRetryProcessor] function called at"
  QUERY
    , "pagopareceiptpdfnotifier" # from HELM's parameter WEBSITE_SITE_NAME https://github.com/pagopa/pagopa-receipt-pdf-notifier/helm/values-prod.yaml
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

## Alert
# This alert cover the following error case:
# 1. ReceiptToIoService execution logs that a receipt could not be notified (due to maximum retries, or failing to send to message queue)
# https://github.com/pagopa/pagopa-receipt-pdf-notifier/blob/26067525b154796962168e661ee932d4e628f1be/src/main/java/it/gov/pagopa/receipt/pdf/notifier/service/impl/ReceiptToIOServiceImpl.java#L333

resource "azurerm_monitor_scheduled_query_rules_alert" "receipt-unable-to-notify-alert" {
  count               = var.env_short != "d" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-unable-to-send-notify"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Failed to notify receipt to IO"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Unable to notify to IO due to exceeding number of retries, or failing to send to retry management queue"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where message contains "Receipt updated with status UNABLE_TO_SEND"
  QUERY
    , "pagopareceiptpdfnotifier" # from HELM's parameter WEBSITE_SITE_NAME https://github.com/pagopa/pagopa-receipt-pdf-notifier/helm/values-prod.yaml
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


