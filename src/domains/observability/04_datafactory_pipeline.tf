########################### KPI TPNP ###########################
resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPNP" {

  name            = "SMO_KPI_TPNP_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id       = "",
    start_date   = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPNP.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPNP_DataSet"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TPNP" {

  name            = "Trigger_KPI_TPNP"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 10
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Description of Trigger_KPI_TPNP"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TPNP.name

}



########################### KPI TPNP RECUPERO ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPNP_Recupero" {

  name            = "SMO_KPI_TPNP_Recupero_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  parameters = {
    run_id     = "09753e8b-7920-453a-b54c-512ec3e39756"
    start_date = ""
  }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPNP_Recupero.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPNP_DataSet"
  })}]"

}






########################### KPI TNSPO ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_TNSPO" {

  name            = "SMO_KPI_TNSPO_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id       = "",
    start_date   = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TNSPO.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TNSPO_Dataset"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TNSPO" {

  name            = "Trigger_KPI_TNSPO"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 10
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Description of Trigger_KPI_TNSPO"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TNSPO.name

}


########################### KPI TNSPO_DASPO ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPSPO_DASPO" {

  name            = "SMO_KPI_KPI_TPSPO_DASPO_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id       = "",
    start_date   = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPSPO_DASPO.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPSPO_DASPO_Dataset"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TPSPO_DASPO" {

  name            = "Trigger_KPI_TPSPO_DASPO"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 30
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Description of Trigger_KPI_TPSPO_DASPO"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TPSPO_DASPO.name

}


########################### KPI FDR IMPORT ESITI ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_FDR_IMPORT_ESITI" {

  name            = "SMO_KPI_FDR_IMPORT_ESITI_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  variables = {
    date_trigger = "",
    date_start   = "",
    date_end     = "",
    date_only    = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_FDR_IMPORT_ESITI.json", {
    cosmos_dataset  = "SMO_COSMOS_BIZEVENTS_OK_DataSet"
    esiti_dataset   = "SMO_KPI_ESITI_DAILY_DataSet"
    details_dataset = "SMO_KPI_RENDICONTAZIONI_DETAILS_DataSet"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_FDR_IMPORT_ESITI" {

  name            = "Trigger_KPI_FDR_IMPORT_ESITI"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 1
  frequency = "Hour"
  activated = true
  time_zone = "W. Europe Standard Time"
  start_time = "2023-12-13T14:10:00Z"

  description   = "Description of Trigger_KPI_FDR_IMPORT_ESITI"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_FDR_IMPORT_ESITI.name

}

########################### KPI FDR IMPORT ESITI MANUALE ###########################

resource "azurerm_data_factory_pipeline" "pipeline_KPI_FDR_IMPORT_ESITI_Manuale" {

  name            = "SMO_KPI_FDR_IMPORT_ESITI_Manuale_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  parameters = {
    date_trigger = ""
  }

  variables = {
    date_start = "",
    date_end   = "",
    date_only  = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_FDR_IMPORT_ESITI_Manuale.json", {
    cosmos_dataset  = "SMO_COSMOS_BIZEVENTS_OK_DataSet"
    esiti_dataset   = "SMO_KPI_ESITI_DAILY_DataSet"
    details_dataset = "SMO_KPI_RENDICONTAZIONI_DETAILS_DataSet"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}





########################### KPI FDR IMPORT ESITI MANUALE DAILY ###########################

resource "azurerm_data_factory_pipeline" "pipeline_KPI_FDR_IMPORT_ESITI_DAILY_Manuale" {

  name            = "SMO_KPI_FDR_IMPORT_ESITI_DAILY_Manuale_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")


  parameters = {
    date_trigger = "",
    nh           = 24
  }

  variables = {
    i          = "",
    _i         = "",
    date_start = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_FDR_IMPORT_ESITI_DAILY_Manuale.json", {
    reference_pipeline = "SMO_KPI_FDR_IMPORT_ESITI_Manuale_Pipeline"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}



########################### KPI FDR ELABORAZIONE ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_FDR_RENDICONTAZIONI" {

  name            = "SMO_KPI_FDR_RENDICONTAZIONI_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  variables = {
    date_trigger = "",
    date_start   = "",
    date_end     = "",
    date_only    = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_FDR_RENDICONTAZIONI.json", {
    inputdataset  = "SMO_KPI_RENDICONTAZIONI_DETAILS_DataSet"
    outputdataset = "SMO_KPI_RENDICONTAZIONI_DataSet"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}


resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_FDR_RENDICONTAZIONI" {

  name            = "Trigger_KPI_FDR_RENDICONTAZIONI"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 1
  frequency = "Day"
  activated = true
  time_zone = "W. Europe Standard Time"
  schedule {
    hours   = [3]
    minutes = [0]
  }

  description   = "Description of Trigger_KPI_FDR_IMPORT_ESITI"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_FDR_RENDICONTAZIONI.name

}