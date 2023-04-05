prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "ecommerce"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/ecommerce"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

ecommerce_xpay_psps_list = "XPAY,IDPSPFNZ,60000000001"
ecommerce_vpos_psps_list = "BNLIITRR,BIC36019,PSPtest1,CHARITY_AMEX,CHARITY_IDPSPFNZ,CHARITY_ISP,40000000001,DINERS,BCITITMM,MARIOGAM,73473473473,PAYTITM1,POSTE1,ProvaCDI,50000000001,70000000001,10000000001,idPsp2,irraggiungibile_wisp,prova_ila_1,pspStress50,pspStress79,pspStress80,pspStress81"

dns_zone_checkout = "dev.checkout"

cidr_subnet_ecommerce_functions = "10.1.157.0/24"

ecommerce_function_always_on = true

ecommerce_functions_app_sku = {
  kind     = "Linux"
  sku_tier = "Basic"
  sku_size = "B1"
}

ecommerce_functions_autoscale = {
  default = 1
  minimum = 1
  maximum = 3
}
