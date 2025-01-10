resource "elasticstack_elasticsearch_snapshot_repository" "snapshot_repository" {
  name = "default_snapshot_backup"

  azure {
    container = "snapshotblob"
    base_path = ""
    chunk_size = "32MB"
    compress = true
    client = local.azure_client_name
  }
}

resource "elasticstack_elasticsearch_snapshot_lifecycle" "default_snapshot_policy" {
  name = "default-nightly-snapshots"

  schedule      = "0 30 1 * * ?"
  snapshot_name = "<nightly-snap-{now/d}>"
  repository    = elasticstack_elasticsearch_snapshot_repository.snapshot_repository.name

  indices              = ["*"]
  ignore_unavailable   = true
  include_global_state = true

  expire_after = "30d"
  min_count    = 5
  max_count    = 50
}
