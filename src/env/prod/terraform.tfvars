# general
env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet = ["10.1.0.0/16"]

# common
cidr_subnet_appgateway         = ["10.1.128.0/24"]
cidr_subnet_postgresql         = ["10.1.129.0/24"]
cidr_subnet_azdoa              = ["10.1.130.0/24"]
cidr_subnet_pagopa_proxy_redis = ["10.1.131.0/24"]
cidr_subnet_pagopa_proxy       = ["10.1.132.0/24"]
cidr_subnet_checkout_be        = ["10.1.133.0/24"]
cidr_subnet_buyerbanks         = ["10.1.134.0/24"]
cidr_subnet_reporting_fdr      = ["10.1.135.0/24"]
cidr_subnet_reporting_common   = ["10.1.136.0/24"]
cidr_subnet_gpd                = ["10.1.138.0/24"]
cidr_subnet_payments           = ["10.1.139.0/24"]
cidr_subnet_canoneunico_common = ["10.1.140.0/24"]

# specific
cidr_subnet_redis = ["10.1.132.0/24"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration = ["10.230.10.0/24"] # ask to SIA

cidr_subnet_apim       = ["10.230.10.0/26"]
cidr_subnet_eventhub   = ["10.230.10.64/26"]
cidr_subnet_api_config = ["10.230.10.128/29"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "platform"
dns_zone_checkout = "checkout"

# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform PROD"
apim_sku            = "Premium_1"
apim_alerts_enabled = true

# app_gateway
app_gateway_api_certificate_name        = "api-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-platform-pagopa-it"
app_gateway_management_certificate_name = "management-platform-pagopa-it"
app_gateway_min_capacity                = 1
app_gateway_max_capacity                = 3
app_gateway_sku_name                    = "WAF_v2"
app_gateway_sku_tier                    = "WAF_v2"
app_gateway_waf_enabled                 = true
app_gateway_alerts_enabled              = true
app_gateway_deny_paths = [
  "/nodo/*",
  "/payment-manager/clients/*",
  "/payment-manager/restapi-rtd/*",
  "/payment-manager/db-logging/*"
]

# nat_gateway
nat_gateway_enabled    = true
nat_gateway_public_ips = 2

# todo change to Premium before launch
# redis_sku_name = "Premium"
# redis_family   = "P"

# postgresql
prostgresql_enabled                      = false
postgresql_sku_name                      = "GP_Gen5_2" # todo change before launch
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = false
postgres_private_endpoint_enabled        = false

# mock
mock_ec_enabled  = false
mock_psp_enabled = false

# api_config
api_config_enabled = false

# apim x nodo pagmenti
nodo_pagamenti_enabled = true
nodo_pagamenti_psp     = "97249640588,08658331007,05425630968,06874351007,08301100015,02224410023,02224410023,06529501006,00194450219,02113530345,01369030935,07783020725,00304940980"
nodo_pagamenti_ec      = "00493410583,09633951000,06655971007,00856930102,02478610583,97169170822,01266290996,01248040998,01429910183,80007270376,01142420056,80052310580,83000730297,80082160013,94050080038,01032450072,01013130073,10718570012,01013210073,87007530170,01242340998,80012150274,02508710585,80422850588,94032590278,94055970480,92001600524,80043570482,92000530532,80094780378,80016430045,80011170505,80031650486,00337870406,09227921005,01928010683,00608810057,03299640163,82002730487,02928200241"
nodo_pagamenti_url     = "https://10.79.20.34/webservices/input"
ip_nodo                = "10.79.20.34"

# eventhub
eventhub_enabled = true

# checkout
checkout_enabled = true

# checkout function
checkout_function_kind              = "Linux"
checkout_function_sku_tier          = "PremiumV3"
checkout_function_sku_size          = "P1v3"
checkout_function_always_on         = true
checkout_function_autoscale_minimum = 1
checkout_function_autoscale_maximum = 3
checkout_function_autoscale_default = 1
checkout_pagopaproxy_host           = "https://io-p-app-pagopaproxyprod.azurewebsites.net"

ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5

ehns_alerts_enabled = false
ehns_metric_alerts = {
  no_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "No transactions received from acquirer in the last 24h"
    operator    = "LessThanOrEqual"
    threshold   = 1000
    frequency   = "PT1H"
    window_size = "P1D"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values   = ["rtd-trx"]
      }
    ],
  },
  active_connections = {
    aggregation = "Average"
    metric_name = "ActiveConnections"
    description = null
    operator    = "LessThanOrEqual"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT15M"
    dimension   = [],
  },
  error_trx = {
    aggregation = "Total"
    metric_name = "IncomingMessages"
    description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
    operator    = "GreaterThan"
    threshold   = 0
    frequency   = "PT5M"
    window_size = "PT30M"
    dimension = [
      {
        name     = "EntityName"
        operator = "Include"
        values = ["nodo-dei-pagamenti-log",
        "nodo-dei-pagamenti-re"]
      }
    ],
  },
}

eventhubs = [
  {
    name              = "nodo-dei-pagamenti-log"
    partitions        = 32
    message_retention = 7
    consumers         = ["logstash-pdnd", "logstash-oper", "logstash-tech"]
    keys = [
      {
        name   = "logstash-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "logstash-pdnd"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-oper"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-tech"
        listen = true
        send   = false
        manage = false
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-re"
    partitions        = 30
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-pdnd" # pdnd
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-oper" # oper
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-fdr"
    partitions        = 32
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-pdnd", "nodo-dei-pagamenti-oper"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-pdnd" # pdnd
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-oper" # oper
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]

# acr
acr_enabled = true

# db nodo dei pagamenti
db_port                            = 1521
db_service_name                    = "NDPSPCP_PP_NODO4_CFG" # TODO chiedere a SIA
dns_a_reconds_dbnodo_ips           = ["10.102.35.61", "10.102.35.62", "10.102.35.63"]
private_dns_zone_db_nodo_pagamenti = "p.db-nodo-pagamenti.com"

# API Config
xsd_ica         = "https://raw.githubusercontent.com/pagopa/pagopa-api/master/general/InformativaContoAccredito_1_2_1.xsd"
api_config_tier = "PremiumV3"
api_config_size = "P1v3"

# API Config FE
api_config_fe_enabled = true
cname_record_name     = "config"

# buyerbanks functions
buyerbanks_function_kind              = "Linux"
buyerbanks_function_sku_tier          = "PremiumV3"
buyerbanks_function_sku_size          = "P1v3"
buyerbanks_function_autoscale_minimum = 1
buyerbanks_function_autoscale_maximum = 3
buyerbanks_function_autoscale_default = 1
buyerbanks_delete_retention_days      = 30

# pagopa-proxy app service
pagopa_proxy_enabled        = false
pagopa_proxy_redis_capacity = 0
pagopa_proxy_redis_sku_name = "Standard"
pagopa_proxy_redis_family   = "C"
pagopa_proxy_tier           = "PremiumV3"
pagopa_proxy_size           = "P1v3"
# TODO this is dev value ... replace with uat value.
nodo_ip_filter = "10.79.20.32"

# payment-manager clients
io_bpd_hostname    = "portal.test.pagopa.gov.it" #TO UPDATE with prod hostname
xpay_hostname      = "ecommerce.nexi.it"
paytipper_hostname = "st.paytipper.com"
bpd_hostname       = "api.cstar.pagopa.it"
cobadge_hostname   = "portal.test.pagopa.gov.it" #TO UPDATE with prod hostname
fesp_hostname      = "portal.test.pagopa.gov.it"

# fdr
fdr_delete_retention_days        = 30
reporting_fdr_function_kind      = "Linux"
reporting_fdr_function_sku_tier  = "PremiumV3"
reporting_fdr_function_sku_size  = "P1v3"
reporting_fdr_function_always_on = true


# gpd
gpd_plan_kind     = "Linux"
gpd_plan_sku_tier = "PremiumV3"
gpd_plan_sku_size = "P1v3"

reporting_function_autoscale_minimum = 1
reporting_function_autoscale_maximum = 3
reporting_function_autoscale_default = 1

reporting_batch_function_always_on    = true
reporting_service_function_always_on  = true
reporting_analysis_function_always_on = true

reporting_analysis_function_always_on         = true
reporting_analysis_function_autoscale_minimum = 1
reporting_analysis_function_autoscale_maximum = 3
reporting_analysis_function_autoscale_default = 1

// GPD Payments
payments_paa_id_intermediario = "77777777777"   // TODO
payments_paa_stazione_int     = "77777777777_1" // TODO

# canone unico
canoneunico_plan_kind     = "Linux"
canoneunico_plan_sku_tier = "PremiumV3"
canoneunico_plan_sku_size = "P1v3"

canoneunico_function_always_on         = true
canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1
