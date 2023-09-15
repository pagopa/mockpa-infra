module "tls_checker" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker?ref=v6.3.0"

  https_endpoint                         = local.qi_hostname
  alert_name                             = local.qi_hostname
  alert_enabled                          = true
  helm_chart_present                     = true
  helm_chart_version                     = var.tls_cert_check_helm.chart_version
  namespace                              = kubernetes_namespace.namespace.metadata[0].name
  helm_chart_image_name                  = var.tls_cert_check_helm.image_name
  helm_chart_image_tag                   = var.tls_cert_check_helm.image_tag
  location_string                        = var.location_string
  application_insights_connection_string = "ai-${var.env_short}-connection-string"
  application_insights_resource_group    = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids  = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                          = data.azurerm_key_vault.kv.name
  keyvault_tenantid                      = data.azurerm_client_config.current.tenant_id
}

resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "1.0.4"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    "${
      templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
        NAMESPACE        = var.domain,
        DOMAIN           = var.domain
        CERTIFICATE_NAME = replace(local.qi_hostname, ".", "-"),
        ENV_SHORT        = var.env_short,
      })
    }"
  ]
}


module "pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v6.3.0"

  resource_group_name = local.aks_resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id
  cluster_name        = local.aks_name

  identity_name = "${kubernetes_namespace.namespace.metadata[0].name}-pod-identity" // TODO add env in name
  namespace     = kubernetes_namespace.namespace.metadata[0].name
  key_vault_id  = data.azurerm_key_vault.kv.id

  secret_permissions = ["Get"]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v0.0.110"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
