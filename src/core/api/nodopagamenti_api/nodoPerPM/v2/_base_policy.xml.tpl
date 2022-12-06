<policies>
    <inbound>
      <base />
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

<policies>
    <inbound>
        <base />
        <set-backend-service base-url="${base-url}/v2" />

        <!-- onprem -->
        <!-- <set-backend-service base-url="http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input" /> -->
        <choose>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Contains("prf.platform.pagopa.it"))">
                <set-backend-service base-url="http://{{aks-lb-nexi}}/nodo-prf" />
            </when>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("uat.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Contains("uat.platform.pagopa.it"))">
                <!-- <set-backend-service base-url="http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}" /> -->
                <set-backend-service base-url="https://10.79.20.32" />
                <!-- onprem -->
            </when>
            <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("dev.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Contains("dev.platform.pagopa.it"))">
                <set-backend-service base-url="http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}" />
            </when>
        </choose>
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>