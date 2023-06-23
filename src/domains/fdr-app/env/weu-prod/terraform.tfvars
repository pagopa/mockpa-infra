prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "fdr"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/fdr"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}


# function app
reporting_fdr_function_always_on = true

app_service_plan_info = {
  kind                         = "Linux"
  sku_size                     = "P1v3"
  maximum_elastic_worker_count = 1
  worker_count                 = 1
  zone_balancing_enabled       = false
}

storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain                           = "pagopa.it"
dns_zone_internal_prefix                  = "internal.platform"
apim_dns_zone_prefix                      = "platform"
eventhub_name                             = "nodo-dei-pagamenti-fdr"
event_name                                = "nodo-dei-pagamenti-tx"
private_endpoint_network_policies_enabled = false

# common
cidr_subnet_reporting_fdr = ["10.1.135.0/24"]

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.0.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4@sha256:c3d45736706c981493b6216451fc65e99a69d5d64409ccb1c4ca93fef57c921d"
}

# docker image
image_name = "pagopapcommonacr.azurecr.io/reporting-fdr"
image_tag  = "1.1.0"

apim_fdr_nodo_pagopa_enable = false
