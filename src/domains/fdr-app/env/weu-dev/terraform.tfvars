prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "fdr"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/fdr"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# function app
reporting_fdr_function_always_on = false

app_service_plan_info = {
  kind                         = "Linux"
  sku_size                     = "S1"
  maximum_elastic_worker_count = 1
  worker_count                 = 1
  zone_balancing_enabled       = false
}
fn_app_runtime_version = "~4"

storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = false
}

reporting_fdr_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = false
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain                           = "pagopa.it"
dns_zone_internal_prefix                  = "internal.dev.platform"
apim_dns_zone_prefix                      = "dev.platform"
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
image_name = "reporting-fdr"
image_tag  = "latest"

apim_fdr_nodo_pagopa_enable = true # 👀 https://pagopa.atlassian.net/wiki/spaces/PN5/pages/647497554/Design+Review+Flussi+di+Rendicontazione

# fdr re
fdr_re_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
}
fdr_re_function_subnet                   = ["10.1.181.0/24"]
fdr_re_function_network_policies_enabled = false
fdr_re_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

# fdr xml to json
fdr_xml_to_json_function_subnet                   = ["10.1.182.0/24"]
fdr_xml_to_json_function_network_policies_enabled = false
fdr_xml_to_json_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
}

fdr_xml_to_json_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

# fdr json to xml
fdr_json_to_xml_function_subnet                   = ["10.1.185.0/24"]
fdr_json_to_xml_function_network_policies_enabled = false
fdr_json_to_xml_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = null
}

fdr_json_to_xml_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}

ftp_organization = "55555555555,90000000002,88888888888,11111111111,paStress4,44444444444,19721972197,11111122222,66666666666,55555666666,89898989898,20000000002,11111122223,11223344551,15376371009_FTP"


