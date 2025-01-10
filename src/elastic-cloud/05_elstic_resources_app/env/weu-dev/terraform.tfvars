env_short       = "d"
env             = "dev"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/elk-monitoring"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# same between dev and uat
ec_deployment_id = "0a5530b19ca67de6b3cf71f02082443d"

lifecycle_policy_wait_for_snapshot = false
