<policies>
    <inbound>
      <cors>
        <allowed-origins>
          <origin>${origin}</origin>
        </allowed-origins>
        <allowed-methods>
          <method>POST</method>
          <method>GET</method>
          <method>OPTIONS</method>
        </allowed-methods>
        <allowed-headers>
          <header>Content-Type</header>
        </allowed-headers>
      </cors>
      <base />
      <set-backend-service base-url="{{pagopa-appservice-proxy-url}}" />
      <rate-limit-by-key calls="150" renewal-period="10" counter-key="@(context.Request.Headers.GetValueOrDefault("X-Forwarded-For"))" />
    </inbound>
    <outbound>
        <set-header name="cache-control" exists-action="override">
            <value>no-store</value>
        </set-header>
        <set-variable name="body" value="@(context.Response.Body.As<JObject>())" />
        <choose>
            <when condition="@(context.Response.StatusCode == 500 && ((JObject) context.Variables["body"])["detail_v2"] != null )">
                <return-response>
                    <set-status code="400" />
                    <set-body>@{
                    return new JObject(
                            new JProperty("status", 400),
                            new JProperty("detail", ((JObject) context.Variables["body"])["detail_v2"]),
                            new JProperty("title", ((JObject) context.Variables["body"])["title"])
                           ).ToString();
             }</set-body>
                </return-response>
            </when>
            <when condition="@(context.Response.StatusCode != 500)">
                <return-response>
                    <set-status code="@(context.Response.StatusCode)" />
                    <set-body>@(((JObject) context.Variables["body"]).ToString())</set-body>
                </return-response>
            </when>
        </choose>
        <base />
    </outbound>
    <backend>
      <base />
    </backend>
    <on-error>
      <base />
    </on-error>
  </policies>
