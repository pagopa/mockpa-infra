prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "printit"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/printit-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_italy_resource_group_name                 = "pagopa-p-itn-core-monitor-rg"
log_analytics_italy_workspace_name                = "pagopa-p-itn-core-law"
log_analytics_italy_workspace_resource_group_name = "pagopa-p-itn-core-monitor-rg"

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"
dns_zone_prefix          = "printit.itn"
apim_dns_zone_prefix     = "platform"
### Aks

ingress_load_balancer_ip = "10.3.2.250"



# pdf-engine
is_feature_enabled = {
  pdf_engine = true
  printit    = true
}

app_service_pdf_engine_sku_name      = "P2v3"
app_service_pdf_engine_autoscale_enabled = true
app_service_pdf_engine_always_on = true
app_service_pdf_engine_zone_balancing_enabled = true

app_service_pdf_engine_sku_name_java = "P1v3"
app_service_pdf_engine_sku_name_java_zone_balancing_enabled = true

