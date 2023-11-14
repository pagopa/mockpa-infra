<policies>
    <inbound>
      <!-- Extract payment method name for create redirectUrl -->
      <set-variable name="requestBody" value="@(context.Request.Body.As<JObject>(preserveContent: true))" />
      <set-variable name="paymentMethodId" value="@((string)((JObject) context.Variables["requestBody"])["paymentMethodId"])" />
      <send-request ignore-error="false" timeout="10" response-variable-name="paymentMethodsResponse">
          <set-url>@("https://${ecommerce-basepath}/pagopa-ecommerce-payment-methods-service/payment-methods/" + context.Variables["paymentMethodId"])</set-url>
          <set-method>GET</set-method>
      </send-request>
      <choose>
          <when condition="@(((IResponse)context.Variables["paymentMethodsResponse"]).StatusCode != 200)">
              <return-response>
              <set-status code="502" reason="Bad Gateway" />
              <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
              </set-header>
              <set-body>
                  {
                      "title": "Error retrieving eCommerce payment methods",
                      "status": 502,
                      "detail": "There was an error retrieving eCommerce payment methods"
                  }
              </set-body>
              </return-response>
          </when>
      </choose>
      <set-variable name="paymentMethodsResponseBody" value="@(((IResponse)context.Variables["paymentMethodsResponse"]).Body.As<JObject>())" />
      <set-variable name="paymentMethodName" value="@((string)((JObject) context.Variables["paymentMethodsResponseBody"])["name"])" />
      <set-variable name="redirectUrlPrefix" value="@{
              string returnedPaymentMethodName = (string)context.Variables["paymentMethodName"];
              var paymentMethodNameTypes = new Dictionary<string, string>
                  {
                      { "CARDS", "pm-onboarding/creditcard" },
                      { "BPAY", "pm-onboarding/bpay" },
                      { "PPAL", "pm-onboarding/paypal" }
                  };

              if (paymentMethodNameTypes.ContainsKey(returnedPaymentMethodName)) {
                  return paymentMethodNameTypes[returnedPaymentMethodName];
              }
              return "";
      }" />
      <choose>
        <when condition="@((string)context.Variables.GetValueOrDefault("redirectUrlPrefix","") == "")">
            <return-response>
               <set-status code="502" reason="Bad Gateway" />
               <set-header name="Content-Type" exists-action="override">
                  <value>application/json</value>
               </set-header>
               <set-body>
                   {
                       "title": "Error retrieving eCommerce payment methods",
                       "status": 502,
                       "detail": "Invalid payment method name"
                   }
               </set-body>
            </return-response>
        </when>
      </choose>
      <!-- End extract payment method name for create redirectUrl -->

      <!-- Session PM START-->
      <send-request ignore-error="true" timeout="10" response-variable-name="pm-session-body" mode="new">
          <set-url>@($"{{pm-host}}/pp-restapi-CD/v1/users/actions/start-session?token={(string)context.Variables["walletToken"]}")</set-url>
          <set-method>GET</set-method>
      </send-request>
       <choose>
        <when condition="@(((IResponse)context.Variables["pm-session-body"]).StatusCode != 200)">
          <return-response>
            <set-status code="502" reason="Bad Gateway" />
          </return-response>
        </when>
      </choose>
      <set-variable name="pmSession" value="@(((IResponse)context.Variables["pm-session-body"]).Body.As<JObject>())" />
      <return-response>
        <set-status code="201" />
        <set-header name="Content-Type" exists-action="override">
          <value>application/json</value>
        </set-header>
        <set-body>@{
            return new JObject(
                          new JProperty("redirectUrl", $"https://${env}.payment-wallet.pagopa.it/" + $"{(string)context.Variables["redirectUrlPrefix"]}" + $"#sessionToken={((string)((JObject) context.Variables["pmSession"])["data"]["sessionToken"])}")
                ).ToString();
        }</set-body>
      </return-response>
      <!-- Session PM END-->
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
