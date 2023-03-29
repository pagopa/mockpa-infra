locals {
  administrator_login    = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  administrator_password = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value

}

resource "azurerm_resource_group" "data_factory_rg" {
  name     = format("%s-df-rg", local.project)
  location = var.location
  tags     = var.tags
}


resource "azurerm_data_factory" "data_factory" {
  name                   = format("%s-df", local.project)
  location               = azurerm_resource_group.data_factory_rg.location
  resource_group_name    = azurerm_resource_group.data_factory_rg.name
  public_network_enabled = false

  # Still doesn't work: https://github.com/hashicorp/terraform-provider-azurerm/issues/12949
  managed_virtual_network_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_data_factory_integration_runtime_azure" "autoresolve" {
  name = "AutoResolveIntegrationRuntime"
  # resource_group_name     = azurerm_resource_group.data_factory_rg.name
  data_factory_id         = azurerm_data_factory.data_factory.id
  location                = "AutoResolve"
  virtual_network_enabled = true
}

resource "azurerm_private_endpoint" "data_factory_pe" {
  name                = format("%s-pe", azurerm_data_factory.data_factory.name)
  location            = azurerm_resource_group.data_factory_rg.location
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  subnet_id           = data.azurerm_subnet.private_endpoint_snet.id

  private_dns_zone_group {
    name                 = format("%s-private-dns-zone-group", azurerm_data_factory.data_factory.name)
    private_dns_zone_ids = [azurerm_private_dns_zone.adf.id]
  }

  private_service_connection {
    name                           = format("%s-private-service-connection", azurerm_data_factory.data_factory.name)
    private_connection_resource_id = azurerm_data_factory.data_factory.id
    is_manual_connection           = false
    subresource_names              = ["datafactory"]
  }

  tags = var.tags
}

resource "azurerm_private_dns_a_record" "data_factory_a_record" {
  name                = azurerm_data_factory.data_factory.name
  zone_name           = azurerm_private_dns_zone.adf.name
  resource_group_name = azurerm_private_dns_zone.adf.resource_group_name
  ttl                 = 300
  records             = azurerm_private_endpoint.data_factory_pe.private_service_connection.*.private_ip_address

  tags = var.tags
}

resource "azurerm_data_factory_linked_service_postgresql" "data_factory_ls" {
  name                = "AzurePostgreSqlLinkedService"
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = azurerm_resource_group.data_factory_rg.name
  connection_string   = "host=pagopa-${var.env_short}-weu-nodo-flexible-postgresql.postgres.database.azure.com;port=5432;database=nodo;uid=${local.administrator_login};encryptionmethod=1;validateservercertificate=0;password=${local.administrator_password}"
  additional_properties = {
    "type" : "AzurePostgreSql"
  }
}
