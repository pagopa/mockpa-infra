# kibana space configuration



this folder contains the kibana spaces, indexes and data stream configuration for every application.


folder structure:

```commandline
├── ndp //determines the name of the kibana space
│ └── nodo.json // resources and visualizations associated with the above space
└── printit // another kibana space
    ├── dashboards // dashboard for this application
    │ └── dashboard_massive.ndjson
    └── printit.json
```


Define a new json file containing all the required information to allow the creation of a space and all required resource to manage the logs of an application.

