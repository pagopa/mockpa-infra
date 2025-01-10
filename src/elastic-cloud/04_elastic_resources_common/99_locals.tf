locals {
  prefix = "pagopa"
  project = "${local.prefix}-${var.env_short}-${var.location_short}-ec"
  realm_name = "kibana-realm"
  azure_client_name = "pagopa${var.env}"
  admins_email = [
    "marco.mari@pagopa.it",
    "matteo.alongi@pagopa.it",
    "diego.lagosmorales@pagopa.it",
    "umberto.coppolabottazzi@pagopa.it",
    "fabio.felici@pagopa.it"
  ]
}
