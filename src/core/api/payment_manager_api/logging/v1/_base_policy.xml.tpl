<policies>
    <inbound>
      <base />
      <set-backend-service base-url="@(String.Format("{{pm-gtw-hostname}}:{0}/db-logging", (string)context.Variables["pm-gtw-port"]))" />
    </inbound>
    <outbound>
      <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
