prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "nodo"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/nodo-app"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
apim_dns_zone_prefix     = "uat.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}
<<<<<<< HEAD

nodo_user_node_pool = {
  enabled         = true
  name            = "nodocron01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "1" #TODO change to 2 or 3 in prod
  node_count_max  = "2"
  node_labels = {
  "nodo-cron" = "true", },
  node_taints        = [],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}

aks_cidr_subnet = ["10.1.0.0/17"]
=======
>>>>>>> 5509c01a (feat: New nodo-cron domain and nodo secret value (#615))
