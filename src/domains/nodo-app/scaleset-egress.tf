resource "azurerm_resource_group" "vmss_rg" {
  name     = format("%s-vmss-rg", local.project)
  location = var.location

  tags = var.tags
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_resource_group_name
}

module "vmss_snet" {
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.13"
  name                                           = format("%s-vmss-snet", local.project)
  address_prefixes                               = var.cidr_subnet_vmss
  resource_group_name                            = local.vnet_resource_group_name
  virtual_network_name                           = data.azurerm_virtual_network.vnet_integration.name
  enforce_private_link_endpoint_network_policies = true
}

data "azurerm_key_vault_secret" "vmss_admin_login" {
  name         = "vmss-administrator-login"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-administrator-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss-egress" {
  name                            = format("%s-vmss", local.project)
  resource_group_name             = azurerm_resource_group.vmss_rg.name
  location                        = azurerm_resource_group.vmss_rg.location
  sku                             = "Standard_D4ds_v5"
  instances                       = 1
  admin_username                  = data.azurerm_key_vault_secret.vmss_admin_login.value
  admin_password                  = data.azurerm_key_vault_secret.vmss_admin_password.value
  disable_password_authentication = false
  zones                           = ["1"]



  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.7"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "egress-input"
    primary                       = true
    enable_ip_forwarding          = true
    enable_accelerated_networking = true

    ip_configuration {
      name                                   = "egress-in"
      primary                                = true
      subnet_id                              = module.vmss_snet.id
      load_balancer_backend_address_pool_ids = [module.load_balancer_nodo_egress.azurerm_lb_backend_address_pool_id]
    }
  }
  network_interface {
    name                          = "egress-output"
    enable_ip_forwarding          = true
    enable_accelerated_networking = true
    ip_configuration {
      name      = "egress-out"
      primary   = true
      subnet_id = module.vmss_snet.id
    }
  }
}

resource "azurerm_virtual_machine_scale_set_extension" "vmss-extension" {
  name                         = "network-rule-forward"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "script" : "c3VkbyBzeXNjdGwgbmV0LmlwdjQuaXBfZm9yd2FyZD0xCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtdCBuYXQgLUkgUE9TVFJPVVRJTkcgLW8gZXRoMCAtaiBNQVNRVUVSQURFCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtSSBGT1JXQVJEIC1pIGV0aDEgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtQSBGT1JXQVJEIC1pIGV0aDAgLW8gZXRoMSAtbSBzdGF0ZSAtLXN0YXRlIFJFTEFURUQsRVNUQUJMSVNIRUQgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtdCBuYXQgLUkgUE9TVFJPVVRJTkcgLW8gZXRoMSAtaiBNQVNRVUVSQURFCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtSSBGT1JXQVJEIC1pIGV0aDAgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtQSBGT1JXQVJEIC1pIGV0aDEgLW8gZXRoMCAtbSBzdGF0ZSAtLXN0YXRlIFJFTEFURUQsRVNUQUJMSVNIRUQgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcmVsb2FkCg=="
  })
}


module "load_balancer_nodo_egress" {
  source                                 = "Azure/loadbalancer/azurerm"
  version                                = "3.4.0"
  resource_group_name                    = local.vnet_resource_group_name
  name                                   = format("%s-egress-lb", local.project)
  frontend_name                          = "frontend_private_ip"
  type                                   = "private"
  frontend_subnet_id                     = module.vmss_snet.id
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = var.lb_frontend_private_ip_address
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"

  lb_port = {
    http = ["0", "All", "0"]
  }

  lb_probe = {
    ssh = ["Tcp", "22", ""]
  }

  tags = var.tags

  depends_on = []
}

module "route_table_peering_nexi" {
  source = "git::https://github.com/pagopa/azurerm.git//route_table?ref=v1.0.90"

  name                          = format("%s-aks-to-nexi-rt", local.project)
  location                      = var.location
  resource_group_name           = local.vnet_resource_group_name
  disable_bgp_route_propagation = false

  subnet_ids = [data.azurerm_subnet.aks_snet.id]

  routes = var.route_aks

  tags = var.tags
}