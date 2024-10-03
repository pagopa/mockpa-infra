module "tls_checker" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker?ref=v8.44.3"

  https_endpoint                                            = local.domain_hostname
  alert_name                                                = local.domain_hostname
  alert_enabled                                             = true
  helm_chart_present                                        = true
  namespace                                                 = kubernetes_namespace.namespace.metadata[0].name
  location_string                                           = var.location_string
  kv_secret_name_for_application_insights_connection_string = "app-insight-connection-string"
  application_insights_resource_group                       = data.azurerm_resource_group.monitor_italy_rg.name
  application_insights_id                                   = data.azurerm_application_insights.application_insights_italy.id
  application_insights_action_group_ids                     = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                                             = data.azurerm_key_vault.kv.name
  keyvault_tenant_id                                        = data.azurerm_client_config.current.tenant_id
}

resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "2.0.0"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
      NAMESPACE        = var.domain,
      DOMAIN           = var.domain,
      CERTIFICATE_NAME = replace(local.domain_hostname, ".", "-"),
      ENV_SHORT        = var.env_short,
      KV_NAME          = data.azurerm_key_vault.kv.name
    })
  ]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.1.0"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
