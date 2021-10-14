# general
env_short = "u"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
# main vnet
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_appgateway = ["10.1.128.0/24"]
cidr_subnet_postgresql = ["10.1.129.0/24"]
cidr_subnet_azdoa      = ["10.1.130.0/24"]
# dev/uat only
cidr_subnet_mock_ec  = ["10.1.240.0/29"]
cidr_subnet_mock_psp = ["10.1.240.8/29"]

# integration vnet
# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.230.7.0&mask=24&division=7.31
cidr_vnet_integration  = ["10.230.9.0/24"] # ask to SIA
cidr_subnet_apim       = ["10.230.9.0/26"]
cidr_subnet_api_config = ["10.230.9.128/29"]
cidr_subnet_eventhub   = ["10.230.9.64/26"]

# dns
external_domain   = "pagopa.it"
dns_zone_prefix   = "uat.platform"
dns_zone_checkout = "uat.checkout"
# azure devops
azdo_sp_tls_cert_enabled = true
enable_azdoa             = true
enable_iac_pipeline      = true

# apim
apim_publisher_name = "pagoPA Platform UAT"
apim_sku            = "Developer_1"

# app_gateway
app_gateway_api_certificate_name        = "api-uat-platform-pagopa-it"
app_gateway_portal_certificate_name     = "portal-uat-platform-pagopa-it"
app_gateway_management_certificate_name = "management-uat-platform-pagopa-it"

# postgresql
prostgresql_enabled                      = false
postgresql_sku_name                      = "GP_Gen5_2" # todo fixme verify
postgresql_enable_replica                = false
postgresql_public_network_access_enabled = true
postgresql_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}
prostgresql_db_mockpsp = "mock-psp"

# mock
mock_ec_enabled  = true
mock_psp_enabled = false

# api_config
api_config_enabled = true

# eventhub 
eventhub_enabled = true

# checkout
checkout_enabled = true
ehns_sku_name    = "Standard"

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
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["logstash-rx1", "logstash-rx2", "logstash-rx3"]
    keys = [
      {
        name   = "logstash-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "logstash-rx1"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-rx2"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "logstash-rx3"
        listen = true
        send   = false
        manage = false
      }

    ]
  },
  {
    name              = "nodo-dei-pagamenti-re"
    partitions        = 1 # in PROD shall be changed
    message_retention = 1 # in PROD shall be changed
    consumers         = ["nodo-dei-pagamenti-rx1"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-SIA"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-rx1"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
]

