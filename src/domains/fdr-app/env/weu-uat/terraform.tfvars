prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "fdr"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/fdr"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# function app
reporting_fdr_function_always_on = true

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
  advanced_threat_protection_enable = true
}

reporting_fdr_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

### External resources
monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain                           = "pagopa.it"
dns_zone_internal_prefix                  = "internal.uat.platform"
apim_dns_zone_prefix                      = "uat.platform"
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
  maximum_elastic_worker_count = 0
}
fdr_re_function_subnet                   = ["10.1.181.0/24"]
fdr_re_function_network_policies_enabled = true
fdr_re_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

# fdr xml to json
fdr_xml_to_json_function_subnet                   = ["10.1.182.0/24"]
fdr_xml_to_json_function_network_policies_enabled = true
fdr_xml_to_json_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 0
}

fdr_xml_to_json_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

# fdr json to xml
fdr_json_to_xml_function_subnet                   = ["10.1.185.0/24"]
fdr_json_to_xml_function_network_policies_enabled = true
fdr_json_to_xml_function = {
  always_on                    = true
  kind                         = "Linux"
  sku_size                     = "B1"
  sku_tier                     = "Basic"
  maximum_elastic_worker_count = 0
}

fdr_json_to_xml_function_autoscale = {
  default = 1
  minimum = 1
  maximum = 10
}

ftp_organization = "99999999999,80078750587,88888888888,97532760580,12300020158,00488410010"

enabled_features = {
  eventhub_ha = false
}
