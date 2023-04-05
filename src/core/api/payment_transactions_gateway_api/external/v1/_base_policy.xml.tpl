<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
        </allowed-origins>
        <allowed-methods preflight-result-max-age="300">
          <method>*</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        <expose-headers>
          <header>*</header>
        </expose-headers>
      </cors>
      <base />
      <choose>
        <when condition="@(((string)context.Request.Headers.GetValueOrDefault("X-Orginal-Host-For","")).Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/payment-gateway")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/payment-gateway")" />
        </otherwise>
      </choose>

      <set-variable name="requestPath" value="@(context.Request.Url.Path)" />
      <choose>
          <when condition="@(context.Request.Url.Path.Contains("xpay"))">
              <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("request-payments/xpay","xpay/authorizations"))" />
          </when>
          <when condition="@(context.Request.Url.Path.Contains("vpos"))">
              <rewrite-uri template="@(((string)context.Variables["requestPath"]).Replace("request-payments/vpos","vpos/authorizations"))" />
          </when>
      </choose>
      
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" remaining-calls-header-name="x-rate-limit-remaining" retry-after-header-name="x-rate-limit-retry-after" />
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
