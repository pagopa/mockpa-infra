prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "mock"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/src/domains/mock-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

## APIM
apim_logger_resource_id = "/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-api-rg/providers/Microsoft.ApiManagement/service/pagopa-u-apim/loggers/pagopa-u-apim-logger"

### External resources
monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"
external_domain                             = "pagopa.it"
dns_zone_internal_prefix                    = "internal.uat.platform"
apim_dns_zone_prefix                        = "uat.platform"
dns_zone_prefix                             = "uat.platform"

cidr_subnet_mock_ec              = ["10.1.137.0/29"]
cidr_subnet_mock_payment_gateway = ["10.1.137.8/29"]

lb_aks = "10.70.74.200" # use http protocol + /nodo-<sit|uat|prod> + for SOAP services add /webservices/input


mock_ec_enabled                    = true
mock_ec_secondary_enabled          = true
mock_payment_gateway_enabled       = true
mock_ec_always_on                  = true
mock_psp_service_enabled           = true
mock_psp_secondary_service_enabled = true

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

mock_enabled = false
