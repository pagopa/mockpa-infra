prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "apiconfig"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagopa"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/apiconfig"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain                    = "pagopa.it"
dns_zone_internal_prefix           = "internal.platform"
apim_dns_zone_prefix               = "platform"
private_dns_zone_db_nodo_pagamenti = "p.db-nodo-pagamenti.com"
cidr_subnet_api_config             = ["10.230.10.128/29"]

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "2.8.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.3.4"
}

db_service_name = "NDPSPCP_PP_NODO4_CFG"
db_port         = 1521

# API Config
xsd_ica         = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
api_config_tier = "PremiumV3"
api_config_size = "P1v3"

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"
