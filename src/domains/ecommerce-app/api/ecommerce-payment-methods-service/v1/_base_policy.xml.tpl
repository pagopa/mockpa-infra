<policies>
    <inbound>
      <base />
      <!-- Handle X-Client-Id START-->
      <set-header name="x-client-id" exists-action="delete" />
      <choose>
          <when condition="@(context.User != null && context.User.Groups.Select(g => g.Id).Contains("checkout_rate_no_limit"))">
              <set-header name="x-client-id" exists-action="override">
                  <value>CHECKOUT</value>
              </set-header>
          </when>
          <when condition="@(context.User != null && context.User.Groups.Select(g => g.Id).Contains("payment-wallet"))">
              <set-header name="x-client-id" exists-action="override">
                  <value>IO</value>
              </set-header>
          </when>
      </choose>
      <!-- Handle X-Client-Id END -->
      <set-backend-service base-url="https://${hostname}/pagopa-ecommerce-payment-methods-service" />
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
