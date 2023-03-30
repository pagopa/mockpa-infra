module "elastic_stack" {
  depends_on = [
    azurerm_kubernetes_cluster_node_pool.elastic
  ]

  #source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.13.0"
  source = "/Users/massimoscattarella/projects/pagopa/azurerm/elastic_stack"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  elastic_agent_custom_log_config = {
    pagopafdr = {
      instance = ["pagopafdr"] 
    }
    ndp = {
      instance = ["nodo","nodoreplica","nodocron","nodocronreplica","pagopawebbo","pagopawfespwfesp"]
    }
  }

  eck_license = file("${path.module}/env/eck_license/pagopa-spa-4a1285e5-9c2c-4f9f-948a-9600095edc2f-orchestration.json")

  env_short = var.env_short
  env       = var.env

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}
# output "test1" {
#   value = module.elastic_stack.test
# }

data "kubernetes_secret" "get_elastic_credential" {
  depends_on = [
    module.elastic_stack
  ]

  metadata {
    name      = "quickstart-es-elastic-user"
    namespace = local.elk_namespace
  }
}

locals {
  kibana_url             = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/kibana" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/kibana"
  elastic_url            = var.env_short == "p" ? "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.platform.pagopa.it/elastic" : "https://elastic:${data.kubernetes_secret.get_elastic_credential.data.elastic}@kibana.${var.env}.platform.pagopa.it/elastic"
  # replica_dashboard_path = var.env_short == "d" || var.env_short == "u" ? "nodo/dashboard-replica/*.ndjson" : "nodo/dashboard-replica/*.ndjson_trick_for_not_upload"
  # replica_query_path     = var.env_short == "d" || var.env_short == "u" ? "nodo/query-replica/*.ndjson" : "nodo/query-replica/*.ndjson_trick_for_not_upload"
  # ingest_pipeline        = { for filename in fileset(path.module, "nodo/pipeline/ingest_*.json") : replace(replace(basename(filename), "ingest_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  # ilm_policy             = { for filename in fileset(path.module, "nodo/pipeline/ilm_*.json") : replace(replace(basename(filename), "ilm_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  # component_template     = { for filename in fileset(path.module, "nodo/pipeline/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
}

# resource "null_resource" "ingest_pipeline" {
#   depends_on = [data.kubernetes_secret.get_elastic_credential]

#   for_each = local.ingest_pipeline

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "ilm_policy" {
#   depends_on = [null_resource.ingest_pipeline]

#   for_each = local.ilm_policy

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_ilm/policy/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "component_template" {
#   depends_on = [null_resource.ilm_policy]

#   for_each = local.component_template

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X PUT "${local.elastic_url}/_component_template/${each.key}" \
#       -H 'kbn-xsrf: true' \
#       -H 'Content-Type: application/json' \
#       -d '${each.value}'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "rollover" {
#   depends_on = [null_resource.component_template]

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.elastic_url}/logs-kubernetes.container_logs-default/_rollover/" -H 'kbn-xsrf: true'
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_query" {
#   depends_on = [null_resource.rollover]

#   for_each = fileset(path.module, "nodo/query/*.ndjson")

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_query_replica" {
#   depends_on = [null_resource.upload_query]

#   for_each = fileset(path.module, local.replica_query_path)

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_dashboard" {
#   depends_on = [null_resource.upload_query_replica]

#   for_each = fileset(path.module, "nodo/dashboard/*.ndjson")

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

# resource "null_resource" "upload_dashboard_replica" {
#   depends_on = [null_resource.upload_dashboard]

#   for_each = fileset(path.module, local.replica_dashboard_path)

#   triggers = {
#     always_run = "${timestamp()}"
#   }

#   provisioner "local-exec" {
#     command     = <<EOT
#       curl -k -X POST "${local.kibana_url}/api/saved_objects/_import?overwrite=true" -H 'kbn-xsrf: true' --form "file=@./${each.value}"
#     EOT
#     interpreter = ["/bin/bash", "-c"]
#   }
# }

#################################### [FDR] ####################################
locals {
  pagopafdr_ingest_pipeline    = { for filename in fileset(path.module, "pagopafdr/ingest_*.json") : replace(replace(basename(filename), "ingest_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  pagopafdr_ilm_policy         = { for filename in fileset(path.module, "pagopafdr/ilm_policy_*.json") : replace(replace(basename(filename), "ilm_policy_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  pagopafdr_component_template = { for filename in fileset(path.module, "pagopafdr/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  pagopafdr_index_template     = { for filename in fileset(path.module, "pagopafdr/index_template_*.json") : replace(replace(basename(filename), "index_template_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  pagopafdr_kibana_space       = file("${path.module}/pagopafdr/space.json")
  pagopafdr_kibana_data_view   = file("${path.module}/pagopafdr/data_view.json")
}
resource "null_resource" "pagopafdr_ingest_pipeline" {
   depends_on = [
    module.elastic_stack
  ]

  for_each = local.pagopafdr_ingest_pipeline

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_ilm_policy" {
  depends_on = [null_resource.pagopafdr_ingest_pipeline]

  for_each = local.pagopafdr_ilm_policy

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_component_template" {
  depends_on = [null_resource.pagopafdr_ilm_policy]

  for_each = local.pagopafdr_component_template

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_index_template" {
  depends_on = [null_resource.pagopafdr_component_template]

  for_each = local.pagopafdr_index_template

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_data_stream_rollover" {
  depends_on = [null_resource.pagopafdr_index_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-pagopafdr-pagopafdr-dev/_rollover/" -H 'kbn-xsrf: true'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_kibana_space" {
  depends_on = [null_resource.pagopafdr_data_stream_rollover]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.pagopafdr_kibana_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "pagopafdr_kibana_data_view" {
  depends_on = [null_resource.pagopafdr_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      data_view=$(curl -k -X POST "${local.kibana_url}/s/pagopafdr/api/data_views/data_view" \
        -H 'kbn-xsrf: true' \
        -H 'Content-Type: application/json' \
        -d '${local.pagopafdr_kibana_data_view}')
      
      data_view_id=$(echo $data_view | jq -r ".data_view.id")

      curl -k -X POST "${local.kibana_url}/s/pagopafdr/api/data_views/default" \
        -H 'kbn-xsrf: true' \
        -H 'Content-Type: application/json' \
        -d '{
              "data_view_id": "'$data_view_id'",
              "force": true
            }'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

#################################### [NDP] ####################################
locals {
  ndp_ingest_pipeline    = { for filename in fileset(path.module, "ndp/**/ingest_*.json") : replace(replace(basename(filename), "ingest_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  ndp_ilm_policy         = { for filename in fileset(path.module, "ndp/**/ilm_policy_*.json") : replace(replace(basename(filename), "ilm_policy_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  ndp_component_template = { for filename in fileset(path.module, "ndp/**/component_*.json") : replace(replace(basename(filename), "component_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  ndp_index_template     = { for filename in fileset(path.module, "ndp/**/index_template_*.json") : replace(replace(basename(filename), "index_template_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
  ndp_kibana_space       = file("${path.module}/ndp/space.json")
  ndp_kibana_data_view   = { for filename in fileset(path.module, "ndp/**/data_view_*.json") : replace(replace(basename(filename), "data_view_", ""), ".json", "") => replace(trimsuffix(trimprefix(file("${path.module}/${filename}"), "\""), "\""), "'", "'\\''") }
}
resource "null_resource" "ndp_ingest_pipeline" {
  depends_on = [
    module.elastic_stack
  ]

  for_each = local.ndp_ingest_pipeline

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ingest/pipeline/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_ilm_policy" {
  depends_on = [null_resource.ndp_ingest_pipeline]

  for_each = local.ndp_ilm_policy

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_component_template" {
  depends_on = [null_resource.ndp_ilm_policy]

  for_each = local.ndp_component_template

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_component_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_index_template" {
  depends_on = [null_resource.ndp_component_template]

  for_each = local.ndp_index_template

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_index_template/${each.key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_data_stream_rollover" {
  depends_on = [null_resource.ndp_component_template]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.elastic_url}/logs-ndp-nodo-dev/_rollover/" -H 'kbn-xsrf: true'
      curl -k -X POST "${local.elastic_url}/logs-ndp-nodoreplica-dev/_rollover/" -H 'kbn-xsrf: true'
      curl -k -X POST "${local.elastic_url}/logs-ndp-nodocron-dev/_rollover/" -H 'kbn-xsrf: true'
      curl -k -X POST "${local.elastic_url}/logs-ndp-nodocronreplica-dev/_rollover/" -H 'kbn-xsrf: true'
      curl -k -X POST "${local.elastic_url}/logs-ndp-pagopawebbo-dev/_rollover/" -H 'kbn-xsrf: true'
      curl -k -X POST "${local.elastic_url}/logs-ndp-pagopawfespwfesp-dev/_rollover/" -H 'kbn-xsrf: true'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_kibana_space" {
  depends_on = [null_resource.ndp_data_stream_rollover]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndp_kibana_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "ndp_kibana_data_view" {
   depends_on = [null_resource.ndp_kibana_space]

  for_each = local.ndp_kibana_data_view

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/ndp/api/data_views/data_view" \
        -H 'kbn-xsrf: true' \
        -H 'Content-Type: application/json' \
        -d '${each.value}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# ## opentelemetry
# resource "helm_release" "opentelemetry_operator_helm" {
#   depends_on = [null_resource.pagopafdr_kibana_data_view]

#   provisioner "local-exec" {
#     when        = destroy
#     command     = "kubectl delete crd opentelemetrycollectors.opentelemetry.io"
#     interpreter = ["/bin/bash", "-c"]
#   }
#   provisioner "local-exec" {
#     when        = destroy
#     command     = "kubectl delete crd instrumentations.opentelemetry.io"
#     interpreter = ["/bin/bash", "-c"]
#   }

#   name       = "opentelemetry-operator"
#   repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
#   chart      = "opentelemetry-operator"
#   version    = var.opentelemetry_operator_helm.chart_version
#   namespace  = local.elk_namespace

#   values = [
#     "${file("${var.opentelemetry_operator_helm.values_file}")}"
#   ]

# }

# resource "kubectl_manifest" "otel_collector" {
#   depends_on = [
#     helm_release.opentelemetry_operator_helm
#   ]
#   yaml_body = templatefile("${path.module}/env/opentelemetry_operator_helm/otel.yaml", {
#     namespace = local.elk_namespace
#   })

#   force_conflicts = true
#   wait            = true
# }