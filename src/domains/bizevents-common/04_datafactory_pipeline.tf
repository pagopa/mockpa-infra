resource "azurerm_data_factory_pipeline" "pipeline_re" {
  count = var.env_short == "p" ? 0 : 1

  depends_on      = [azurerm_data_factory_data_flow.dataflow_recoverTxViews]
  name            = "dataflow_recoverTxViewsPipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory_cosmos.id

  parameters = {
    daysToKeep = 90
  }

  activities_json = file("datafactory/pipelines/recoverTxViews.json")

  lifecycle {
    ignore_changes = [
      activities_json,
    ]
  }
}
