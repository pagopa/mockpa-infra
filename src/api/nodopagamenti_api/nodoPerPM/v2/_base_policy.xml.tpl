<policies>
    <inbound>
      <base />
      <set-backend-service base-url="${base-url}" />
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
