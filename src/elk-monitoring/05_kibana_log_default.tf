#################################### [NDP] ####################################
locals {

  logs_key = "logs"
  logs_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "default policy for the logs index template installed by x-pack reviewed by PagoPA",
    managed = true
  }), "\""), "\""), "'", "'\\''")

  metrics_key = "metrics"
  metrics_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "default policy for the metrics index template installed by x-pack reviewed by PagoPA",
    managed = true
  }), "\""), "\""), "'", "'\\''")
  

}

resource "null_resource" "logs_ilm_policy" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.logs_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.logs_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "metrics_ilm_policy" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.metrics_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.metrics_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

