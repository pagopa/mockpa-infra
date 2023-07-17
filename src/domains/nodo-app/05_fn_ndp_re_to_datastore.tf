# info for cosmos mongodb
data "azurerm_cosmosdb_account" "mongo_ndp_re_account" {
  name                = "${local.project}-cosmos-account"
  resource_group_name = "${local.project}-db-rg"
}

data "azurerm_cosmosdb_mongo_database" "nodo_re" {
  name                = "nodo_re"
  resource_group_name = format("%s-db-rg", local.project)
  account_name        = format("%s-cosmos-account", local.project)
}

# info for event hub
data "azurerm_eventhub_authorization_rule" "pagopa-evh-ns01_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx" {
  name                = "nodo-dei-pagamenti-re-to-datastore-rx"
  namespace_name      = "${local.product}-evh-ns01"
  eventhub_name       = "nodo-dei-pagamenti-re"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

data "azurerm_subnet" "apim_vnet" {
  name                 = local.apim_snet
  resource_group_name  = local.vnet_resource_group_name
  virtual_network_name = local.vnet_integration_name
}

# info for table storage
data "azurerm_storage_account" "nodo_re_storage" {
  name                = replace(format("%s-re-2-data-st", local.project), "-", "")
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-re-to-datastore-rg"
}

resource "azurerm_resource_group" "nodo_re_to_datastore_rg" {
  name     = format("%s-re-to-datastore-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
#  function_re_to_datastore_settings = {
#    FUNCTIONS_WORKER_RUNTIME = "java"
#    // Keepalive fields are all optionals
#    FETCH_KEEPALIVE_ENABLED             = "true"
#    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
#    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
#    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
#    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
#    FETCH_KEEPALIVE_TIMEOUT             = "60000"
#
#    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx.primary_connection_string
#    COSMOS_CONN_STRING   = "mongodb://${local.project}-cosmos-account:${data.azurerm_cosmosdb_account.mongo_ndp_re_account.primary_key}@${local.project}-cosmos-account.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.project}-cosmos-account@"
#  }

  function_re_to_datastore_app_settings = {
    linux_fx_version                    = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME            = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT      = 4
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL      = local.docker_settings.DOCKER_REGISTRY_SERVER_URL
    DOCKER_REGISTRY_SERVER_USERNAME = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
    DOCKER_REGISTRY_SERVER_PASSWORD = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD

    COSMOS_CONN_STRING        = "mongodb://${local.project}-cosmos-account:${data.azurerm_cosmosdb_account.mongo_ndp_re_account.primary_key}@${local.project}-cosmos-account.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@${local.project}-cosmos-account@"
    COSMOS_DB_NAME            = data.azurerm_cosmosdb_mongo_database.nodo_re.name
    COSMOS_DB_COLLECTION_NAME = "events"

    EVENTHUB_CONN_STRING = data.azurerm_eventhub_authorization_rule.pagopa-evh-ns01_nodo-dei-pagamenti-re_nodo-dei-pagamenti-re-to-datastore-rx.primary_connection_string

    TABLE_STORAGE_CONN_STRING = data.azurerm_storage_account.nodo_re_storage.primary_connection_string
    TABLE_STORAGE_TABLE_NAME  = "events"
  }

  docker_settings = {
    # ACR
    DOCKER_REGISTRY_SERVER_URL      = data.azurerm_container_registry.acr.login_server
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }
}

## Function nodo_re_to_datastore
module "nodo_re_to_datastore_function" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v6.20.0"

  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg.name
  name                = "${local.project}-re-to-datastore-fn"

  location          = var.location
  health_check_path = "/info"
  subnet_id         = module.nodo_re_to_datastore_function_snet.id
  runtime_version   = "~4"

  system_identity_enabled = true

  always_on = var.nodo_re_to_datastore_function.always_on

  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  docker = {
    image_name        = "pagopanodoretodatastore"
    image_tag         = var.nodo_re_to_datastore_function_app_image_tag
    registry_password = local.docker_settings.DOCKER_REGISTRY_SERVER_PASSWORD
    registry_url      = "https://${local.docker_settings.DOCKER_REGISTRY_SERVER_URL}"
    registry_username = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
  }

  sticky_connection_string_names = ["COSMOS_CONN_STRING"]
  client_certificate_mode        = "Optional"

  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-re-to-datastore-plan"
  app_service_plan_info = {
    kind                         = var.nodo_re_to_datastore_function.kind
    sku_size                     = var.nodo_re_to_datastore_function.sku_size
    maximum_elastic_worker_count = var.nodo_re_to_datastore_function.maximum_elastic_worker_count
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-re-2-dst-fn-sa", local.project), "-", "")

  app_settings = local.function_re_to_datastore_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

module "nodo_re_to_datastore_function_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.nodo_re_to_datastore_function.app_service_plan_id
  function_app_id                          = module.nodo_re_to_datastore_function.id
  storage_account_name                     = module.nodo_re_to_datastore_function.storage_account_name
  storage_account_access_key               = module.nodo_re_to_datastore_function.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = azurerm_resource_group.nodo_re_to_datastore_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.nodo_re_to_datastore_function.always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.nodo_re_to_datastore_function_snet.id

  # App settings
  app_settings = local.function_re_to_datastore_app_settings

  docker = {
    image_name        = "pagopanodoretodatastore"
    image_tag         = var.nodo_re_to_datastore_function_app_image_tag
    registry_password = data.azurerm_container_registry.acr.admin_password
    registry_url      = "https://${local.docker_settings.DOCKER_REGISTRY_SERVER_URL}"
    registry_username = local.docker_settings.DOCKER_REGISTRY_SERVER_USERNAME
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "nodo_re_to_datastore_function" {
  name                = "${module.nodo_re_to_datastore_function.name}-autoscale"
  resource_group_name = azurerm_resource_group.nodo_re_to_datastore_rg.name
  location            = var.location
  target_resource_id  = module.nodo_re_to_datastore_function.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.nodo_re_to_datastore_function_autoscale.default
      minimum = var.nodo_re_to_datastore_function_autoscale.minimum
      maximum = var.nodo_re_to_datastore_function_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.nodo_re_to_datastore_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.nodo_re_to_datastore_function.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }
  }
}
