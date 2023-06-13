
locals {

  api_2_alerts = var.env_short != "p" ? [] : [
    // node-for-io
    {
      operationId_s : "61dedb1eea7c4a07cc7d47b8",
      primitiva : "activateIOPaymentReq",
      sub_service : "node-for-io",
    },
    // node-for-psp
    {
      operationId_s : "61dedafc2a92e81a0c7a58fb",
      primitiva : "verifyPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fc",
      primitiva : "activatePaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fd",
      primitiva : "sendPaymentOutcome",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fe",
      primitiva : "verificaBollettino",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "62bb23bdea7c4a0f183fc065",
      primitiva : "demandPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "62bb23bdea7c4a0f183fc066",
      primitiva : "nodoChiediCatalogoServiziV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63c559672a92e811a8f33a00",
      primitiva : "activatePaymentNoticeV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63c559672a92e811a8f33a01",
      primitiva : "sendPaymentOutcomeV2",
      sub_service : "node-for-psp",
    },
    // nodo-per-pa
    {
      operationId_s : "61e9633dea7c4a07cc7d480d",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "61e9633dea7c4a07cc7d480e",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec4",
      primitiva : "nodoChiediStatoRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec5",
      primitiva : "nodoChiediListaPendentiRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec6",
      primitiva : "nodoInviaRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec7",
      primitiva : "nodoInviaCarrelloRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec8",
      primitiva : "nodoChiediCopiaRT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec9",
      primitiva : "nodoChiediInformativaPSP",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15eca",
      primitiva : "nodoPAChiediInformativaPA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ecb",
      primitiva : "nodoChiediElencoQuadraturePA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ecc",
      primitiva : "nodoChiediQuadraturaPA",
      sub_service : "nodo-per-pa",
    },
    // nodo-per-psp
    {
      operationId_s : "61dedafb2a92e81a0c7a58f5",
      primitiva : "nodoVerificaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58f6",
      primitiva : "nodoAttivaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "61e9633eea7c4a07cc7d4811",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e77",
      primitiva : "nodoInviaRT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e78",
      primitiva : "nodoChiediInformativaPA",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e79",
      primitiva : "nodoChiediTemplateInformativaPSP",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e7a",
      primitiva : "nodoChiediElencoQuadraturePSP",
      sub_service : "nodo-per-psp",
    },
    // nodo-per-psp-richiesta-avvisi
    {
      operationId_s : "6217ba1a2a92e81fa4f15e75",
      primitiva : "nodoChiediNumeroAvviso",
      sub_service : "nodo-per-psp-richiesta-avvisi",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e76",
      primitiva : "nodoChiediCatalogoServizi",
      sub_service : "nodo-per-psp-richiesta-avvisi",
    },

  ]

}

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "nodoapi-responsetime" {
  for_each            = { for c in local.api_2_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodoapi-${each.value.primitiva}-responsetime"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability ${each.value.primitiva} nodoapi-responsetime "
  enabled        = true
  query = (<<-QUERY
let threshold = 8000;
AzureDiagnostics
| where url_s matches regex "/nodo/${each.value.sub_service}/" 
| where operationId_s == "${each.value.operationId_s}"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
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
