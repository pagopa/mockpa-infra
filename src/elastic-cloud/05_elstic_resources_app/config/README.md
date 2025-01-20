# kibana space configuration



this folder contains the kibana spaces, indexes and data stream configuration for every application.


folder structure:

```commandline
config
├── ndp                         //determines the name of the kibana space
│ ├── nodo                      // application name 
│ │ ├── dashboard               // dashboard for this app: nodo in space: ndp. use "${data_view}" placeholder instead of the data_view_id
│ │ │ ├── Global.ndjson
│ │ │ ├── Monitor_Activate_senza_SPO.ndjson
│ │ │ ├── Monitor_EC.ndjson
│ │ │ ├── Monitor_EC_Applicativo.ndjson
│ │ │ ├── Monitor_Invio_SPO_a_Token_Scaduto.ndjson
│ │ │ ├── Monitor_Tempi_pspNotifyPayment.ndjson
│ │ │ └── Monitor_Tempi_pspNotifyPayment_sendPaymentOutcome.ndjson
│ │ ├── query                   // queries for this app
│ │ │ └── filter_re_jsonlog.ndjson
│ │ └── appSettings.json           // this name is required. this app configuration
├── pagopa                      // another space
│ └── pagopa                    // another application name, same as the space (single app in space)
│     ├── dashboard             // this app dashboards
│     │ └── upload.ndjson
│     └── appSettings.json         // this app configuration
```

