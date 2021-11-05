/**
 * Checkout resource group
 **/
resource "azurerm_resource_group" "checkout_fe_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-fe-rg", local.project)
  location = var.location

  tags = var.tags
}

/**
 * CDN
 */
module "checkout_cdn" {
  source = "git::https://github.com/pagopa/azurerm.git//cdn?ref=v1.0.73"

  count                 = var.checkout_enabled ? 1 : 0
  name                  = "checkout"
  prefix                = local.project
  resource_group_name   = azurerm_resource_group.checkout_fe_rg[0].name
  location              = var.location
  hostname              = format("%s.%s", var.dns_zone_checkout, var.external_domain)
  https_rewrite_enabled = true
  lock_enabled          = var.lock_enable

  index_document     = "index.html"
  error_404_document = "not_found.html"

  dns_zone_name                = azurerm_dns_zone.checkout_public[0].name
  dns_zone_resource_group_name = azurerm_dns_zone.checkout_public[0].resource_group_name

  keyvault_resource_group_name = module.key_vault.resource_group_name
  keyvault_subscription_id     = data.azurerm_subscription.current.subscription_id
  keyvault_vault_name          = module.key_vault.name

  querystring_caching_behaviour = "BypassCaching"

  global_delivery_rule = {
    cache_expiration_action       = []
    cache_key_query_string_action = []
    modify_request_header_action  = []

    # HSTS
    modify_response_header_action = [{
      action = "Overwrite"
      name   = "Strict-Transport-Security"
      value  = "max-age=31536000"
      },
      # Content-Security-Policy (in Report mode)
      {
        action = "Overwrite"
        name   = "Content-Security-Policy-Report-Only"
        value  = format("default-src 'self'; connect-src 'self' https://%s.%s https://api-eu.mixpanel.com https://wisp2.pagopa.gov.it", var.dns_zone_checkout, var.external_domain)
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = " https://acardste.vaservices.eu https://cdn.cookielaw.org;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "img-src 'self' https://acardste.vaservices.eu https://wisp2.pagopa.gov.it data:;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "script-src 'self' https://www.google.com https://www.gstatic.com https://cdn.cookielaw.org;"
      },
      {
        action = "Append"
        name   = "Content-Security-Policy-Report-Only"
        value  = "style-src 'self'  'unsafe-inline'; worker-src 'none';"
      }
    ]
  }

  tags = var.tags
}
