<policies>
    <inbound>
      <base />
      <!-- Handle X-Client-Id - multi channel - START -->
      <set-header name="X-Client-Id" exists-action="delete" />
      <set-variable name="blueDeploymentPrefix" value="@(context.Request.Headers.GetValueOrDefault("deployment","").Contains("blue")?"/beta":"")" />
      <choose>
          <when condition="@( context.Request.Url.Path.Contains("notifications") )">
            <set-backend-service base-url="@("https://${ecommerce_ingress_hostname}"+context.Variables["blueDeploymentPrefix"]+"/pagopa-ecommerce-notifications-service")"/>
          </when>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce"))">
              <set-header name="X-Client-Id" exists-action="override">
                  <value>CLIENT_ECOMMERCE</value>
              </set-header>
          </when>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("payment-manager"))" >
            <set-header name="X-Client-Id" exists-action="override">
              <value>CLIENT_PAYMENT_MANAGER</value>
            </set-header>
          </when>
          <when condition="@(context.User.Groups.Select(g => g.Id).Contains("ecommerce-test"))" >
            <set-header name="X-Client-Id" exists-action="override">
              <value>CLIENT_ECOMMERCE_TEST</value>
            </set-header>
          </when>
          <otherwise>
              <return-response>
                  <set-status code="401" reason="Unauthorized X-Client-Id" />
              </return-response>
          </otherwise>
      </choose>
      <!-- Handle X-Client-Id - multi channel - END -->
      <set-backend-service base-url="https://${hostname}/pagopa-notifications-service" />
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
