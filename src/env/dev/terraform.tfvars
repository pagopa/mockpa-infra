env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# main vnet
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_redis      = ["10.1.132.0/24"]
cidr_subnet_appgateway = ["10.1.128.0/24"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.7.0/24"] # ask to SIA
cidr_subnet_apim      = ["10.230.7.0/26"]


external_domain = "pagopa.it"
dns_zone_prefix = "dev.platform"

lock_enable              = false
azdo_sp_tls_cert_enabled = true

apim_publisher_name = "pagoPA Platform UAT"
apim_sku            = "Developer_1"

app_gateway_api_certificate_name        = "api-dev-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-dev-platform-pagopa-it"
app_gateway_management_certificate_name = "management-dev-platform-pagopa-it"
