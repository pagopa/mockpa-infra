prefix             = "pagopa"
env_short          = "p"
env                = "prod"
domain             = "observ"
location           = "westeurope" # weu
location_short     = "weu"        # weu
location_itn       = "italynorth" # itn
location_short_itn = "itn"        # itn
instance           = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/observability"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name = "pagopa-p-monitor-rg"

# Data Explorer
dexp_params = {
  enabled = true
  sku = {
    name     = "Standard_D11_v2"
    capacity = 2
  }
  autoscale = {
    enabled       = true
    min_instances = 2
    max_instances = 5
  }
  public_network_access_enabled = true
  double_encryption_enabled     = true
  disk_encryption_enabled       = true
  purge_enabled                 = false
}

dexp_db = {
  enable             = true
  hot_cache_period   = "P5D"
  soft_delete_period = "P365D" // "P1Y"
}

dexp_re_db_linkes_service = {
  enable = true
}

external_domain      = "NOT_USED"
apim_dns_zone_prefix = "NOT_USED"

# observability Ingestion cfg
# observability_storage_account_replication_type = "GZRS" # Standard_GZRS, Kind: StorageV2 is not available in zone.
enable_sa_backup                  = true
cidr_subnet_observability_storage = ["10.3.14.0/27"]
cidr_subnet_observability_evh     = ["10.3.14.32/27"]
cidr_subnet_observability_gpd_evh = ["10.3.14.64/27"]
# <free>= ["10.3.14.96/27"]
# <free>= ["10.3.14.128/27"]
# <free>= ["10.3.14.160/27"]


#
# EventHub
#
ehns_sku_name = "Standard"

# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_alerts_enabled           = true
ehns_zone_redundant           = true

ehns_public_network_access       = true
ehns_private_endpoint_is_present = true

eventhubs = [
  {
    name              = "gec-ingestion-bundles-dl"
    partitions        = 32
    message_retention = 7
    consumers         = ["gec-ingestion-bundles-evt-rx", "gec-ingestion-bundles-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-bundles-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-bundles-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-bundles-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-cibundles-dl"
    partitions        = 32
    message_retention = 7
    consumers         = ["gec-ingestion-cibundles-evt-rx", "gec-ingestion-cibundles-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-cibundles-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-cibundles-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-cibundles-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-paymenttypes-dl"
    partitions        = 32
    message_retention = 7
    consumers         = ["gec-ingestion-paymenttypes-evt-rx", "gec-ingestion-paymenttypes-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-paymenttypes-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-paymenttypes-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-paymenttypes-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "gec-ingestion-touchpoints-dl"
    partitions        = 1
    message_retention = 1
    consumers         = ["gec-ingestion-touchpoints-evt-rx", "gec-ingestion-touchpoints-evt-rx-pdnd"]
    keys = [
      {
        name   = "gec-ingestion-touchpoints-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "gec-ingestion-touchpoints-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "gec-ingestion-touchpoints-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "payment-wallet-ingestion-dl"
    partitions        = 32
    message_retention = 7
    consumers         = ["payment-wallet-evt-rx", "payment-wallet-evt-rx-pdnd"]
    keys = [
      {
        name   = "payment-wallet-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "payment-wallet-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "payment-wallet-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]

# alert evh
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
        values   = ["gec-ingestion-bundles-evt-tx", "gec-ingestion-cibundles-evt-tx", "gec-ingestion-paymenttypes-evt-tx", "gec-ingestion-touchpoints-evt-tx"]
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
        values = [
          "gec-ingestion-bundles-evt-rx-pdnd",
          "gec-ingestion-cibundles-evt-rx-pdnd",
          "gec-ingestion-paymenttypes-evt-rx-pdnd",
          "gec-ingestion-touchpoints-evt-rx-pdnd"
        ]
      }
    ],
  },
}




eventhubs_gpd = [
    {
    name              = "test-evh" # test
    partitions        = 1
    message_retention = 1
    consumers         = ["test-evh"]
    keys = [
      {
        name   = "test-evh"
        listen = true
        send   = true
        manage = false
      }
    ]
  },
  # {
  #   name              = "connect-cluster-offsets" # debezium internal use
  #   partitions        = 32
  #   message_retention = 7
  #   consumers         = ["connect-cluster-offsets"]
  #   keys = [
  #     {
  #       name   = "connect-cluster-offsets"
  #       listen = true
  #       send   = true
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "connect-cluster-status" # debezium internal use
  #   partitions        = 32
  #   message_retention = 7
  #   consumers         = ["connect-cluster-offsets"]
  #   keys = [
  #     {
  #       name   = "connect-cluster-status"
  #       listen = true
  #       send   = true
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "connect-cluster-configs" # debezium internal use
  #   partitions        = 32
  #   message_retention = 7
  #   consumers         = ["connect-cluster-configs"]
  #   keys = [
  #     {
  #       name   = "connect-cluster-configs"
  #       listen = true
  #       send   = true
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "gpd-ingestion.apd.payment_option"
  #   partitions        = 32
  #   message_retention = 7
  #   consumers = ["gpd-ingestion.apd.payment_option-rx-dl",]
  #   keys = [
  #     {
  #       name   = "gpd-ingestion.apd.payment_option-rx-dl"
  #       listen = true
  #       send   = false
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "gpd-ingestion.apd.payment_option_metadata"
  #   partitions        = 32
  #   message_retention = 7
  #   consumers = ["gpd-ingestion.apd.payment_option_metadata-rx-dl"]
  #   keys = [
  #     {
  #       name   = "gpd-ingestion.apd.payment_option_metadata-rx-dl"
  #       listen = true
  #       send   = false
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "gpd-ingestion.apd.payment_position"
  #   partitions        = 32
  #   message_retention = 7
  #   consumers = [ "gpd-ingestion.apd.payment_position-rx-dl"]
  #   keys = [
  #     {
  #       name   = "gpd-ingestion.apd.payment_position-rx-dl"
  #       listen = true
  #       send   = true
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "gpd-ingestion.apd.transfer"
  #   partitions        = 32
  #   message_retention = 7
  #   consumers = [ "gpd-ingestion.apd.transfer-rx-dl"]
  #   keys = [
  #     {
  #       name   = "gpd-ingestion.apd.transfer-rx-dl"
  #       listen = true
  #       send   = false
  #       manage = false
  #     }
  #   ]
  # },
  # {
  #   name              = "gpd-ingestion.apd.transfer_metadata"
  #   partitions        = 32
  #   message_retention = 7
  #   consumers = [ "gpd-ingestion.apd.transfer_metadata-rx-dl"]
  #   keys = [
  #     {
  #       name   = "gpd-ingestion.apd.transfer_metadata-rx-dl"
  #       listen = true
  #       send   = false
  #       manage = false
  #     }
  #   ]
  # },
]


# alert evh
# ehns_metric_alerts_gpd = {
#   no_trx = {
#     aggregation = "Total"
#     metric_name = "IncomingMessages"
#     description = "No transactions received from acquirer in the last 24h"
#     operator    = "LessThanOrEqual"
#     threshold   = 1000
#     frequency   = "PT1H"
#     window_size = "P1D"
#     dimension = [
#       {
#         name     = "EntityName"
#         operator = "Include"
#         values   = ["gec-ingestion-bundles-evt-tx", "gec-ingestion-cibundles-evt-tx", "gec-ingestion-paymenttypes-evt-tx", "gec-ingestion-touchpoints-evt-tx"]
#       }
#     ],
#   },
#   active_connections = {
#     aggregation = "Average"
#     metric_name = "ActiveConnections"
#     description = null
#     operator    = "LessThanOrEqual"
#     threshold   = 0
#     frequency   = "PT5M"
#     window_size = "PT15M"
#     dimension   = [],
#   },
#   error_trx = {
#     aggregation = "Total"
#     metric_name = "IncomingMessages"
#     description = "Transactions rejected from one acquirer file received. trx write on eventhub. check immediately"
#     operator    = "GreaterThan"
#     threshold   = 0
#     frequency   = "PT5M"
#     window_size = "PT30M"
#     dimension = [
#       {
#         name     = "EntityName"
#         operator = "Include"
#         values = [
#           "gec-ingestion-bundles-evt-rx-pdnd",
#           "gec-ingestion-cibundles-evt-rx-pdnd",
#           "gec-ingestion-paymenttypes-evt-rx-pdnd",
#           "gec-ingestion-touchpoints-evt-rx-pdnd"
#         ]
#       }
#     ],
#   },
# }
