locals {
  default_ilm = {
    "hot" = {
      "minAge" = "0m",
      "rollover" = {
        "maxPrimarySize" = "50gb",
        "maxAge" = "2d"
      }
    },
    "warm" = {
      "minAge" = "2d",
      "setPriority" = 50
    },
    "cold" = {
      "minAge" = "4d",
      "setPriority" = 0
    },
    "delete" = {
      "minAge" = "7d",
      "deleteSearchableSnapshot" = true,
      "waitForSnapshot" = var.lifecycle_policy_wait_for_snapshot
    }
  }
  default_ingest_pipeline = {
    "processors": [
      {
        "json": {
          "field": "message",
          "add_to_root": true,
          "ignore_failure": true
        }
      },
      {
        "json": {
          "field": "mdc",
          "add_to_root": true,
          "ignore_failure": true
        }
      },
      {
        "convert": {
          "field": "responseTime",
          "type": "long",
          "target_field": "response_time",
          "ignore_missing": true,
          "ignore_failure": true
        }
      },
      {
        "convert": {
          "field": "httpCode",
          "type": "integer",
          "target_field": "http_code",
          "ignore_missing": true,
          "ignore_failure": true
        }
      }
    ]
  }

}
