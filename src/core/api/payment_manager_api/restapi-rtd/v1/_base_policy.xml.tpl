<policies>
    <inbound>
      <base />
      <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>        
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it") || ((string)context.Request.OriginalUrl.ToUri().Host).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-rtd/v1")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-rtd/v1")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
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
