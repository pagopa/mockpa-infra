<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>*</origin>
        </allowed-origins>
        <allowed-methods>
          <method>GET</method>
          <method>POST</method>
          <method>PUT</method>
          <method>DELETE</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>*</header>
        </allowed-headers>
        </cors>
      <base />
      <set-variable name="fromDnsHost" value="@(context.Request.OriginalUrl.Host)" />
      <choose>
        <when condition="@(context.Variables.GetValueOrDefault<string>("fromDnsHost").Contains("prf.platform.pagopa.it"))">
          <set-variable name="backend-base-url" value="@($"{{pm-host-prf}}/pp-restapi-CD/v3")" />
        </when>
        <otherwise>
          <set-variable name="backend-base-url" value="@($"{{pm-host}}/pp-restapi-CD/v3")" />
        </otherwise>
      </choose>
      <set-backend-service base-url="@((string)context.Variables["backend-base-url"])" />
    </inbound>
    <outbound>
      <base />
      <set-variable name="http-pm-host" value="@(Regex.Replace("{{pm-host}}", "https", "http"))" />
        <choose>
            <when condition="@(((string)context.Response.Headers.GetValueOrDefault("location","")).Contains((string)context.Variables.GetValueOrDefault("http-pm-host","")))">
                <set-variable name="locationIn" value=" @(Regex.Replace((string)context.Response.Headers.GetValueOrDefault("location",""), (string)context.Variables.GetValueOrDefault("http-pm-host",""), "https://{{wisp2-it}}"))" />
                <set-header name="location" exists-action="override">
                    <value>@(context.Variables.GetValueOrDefault<string>("locationIn"))</value>
                </set-header>
            </when>
        </choose>
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
