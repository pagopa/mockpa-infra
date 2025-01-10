resource "ec_organization" "pagopa_ec_org" {
  members = {
    "marco.mari@pagopa.it" = {
      organization_role = "organization-admin"
    },
    "matteo.alongi@pagopa.it" = {
      organization_role = "organization-admin"
    }
  }

}
