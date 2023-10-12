<policies>
    <inbound>
        <base />
        <!-- start policy variables -->
        <set-variable name="paymentMethodBackendUri" value="https://${hostname}/pagopa-ecommerce-payment-methods-service" />
        <set-variable name="transactionServiceBackendUri" value="https://${hostname}/pagopa-ecommerce-transactions-service" />
        <set-variable name="orderId" value="@(context.Request.MatchedParameters["orderId"])" />
        <set-variable name="paymentMethodId" value="@(context.Request.Url.Query.GetValueOrDefault("paymentMethodId",""))" />
        <set-variable name="npgNotificationRequestBody" value="@((JObject)context.Request.Body.As<JObject>(true))" />
        <!-- end policy variables -->
        <!-- start request validation
        <validate-content unspecified-content-type-action="prevent" max-size="102400" size-exceeded-action="prevent" errors-variable-name="requestBodyValidation">
           <content type="application/json" validate-as="json" action="prevent" />
        </validate-content>
         end request validation -->
        <!-- payment method verify session -->
        <send-request mode="new" response-variable-name="paymentMethodSessionVerificationResponse" timeout="10" ignore-error="true">
            <set-url>@(String.Format((string)context.Variables["paymentMethodBackendUri"]+"/payment-methods/{0}/sessions/{1}/transactionId", (string)context.Variables["paymentMethodId"], (string)context.Variables["orderId"]))</set-url>
            <set-method>GET</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-header name="Authorization" exists-action="override">
                <value> @{
                        JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
                        return "Bearer " + (string)requestBody["securityToken"];
                    }</value>
            </set-header>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).StatusCode) != 200)">
                <return-response>
                    <set-status code="500" reason="Error retrieving session" />
                </return-response>
            </when>
        </choose>
        <set-variable name="transactionId" value="@(((string)((IResponse)context.Variables["paymentMethodSessionVerificationResponse"]).Body.As<JObject>(preserveContent: true)["transactionId"]))" />
        <!-- end payment method verify session -->
        <!-- send transactions service PATCH request -->
        <send-request mode="new" response-variable-name="transactionServiceAuthorizationPatchResponse" timeout="10" ignore-error="true">
            <set-url>@(String.Format((string)context.Variables["transactionServiceBackendUri"]+"/transactions/{0}/auth-requests", (string)context.Variables["transactionId"]))</set-url>
            <set-method>PATCH</set-method>
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>
                     @{
                        JObject requestBody = (JObject)context.Variables["npgNotificationRequestBody"];
                        JObject operation = (JObject)requestBody["operation"];
                        string operationResult = (string)operation["operationResult"];
                        string orderId = (string)operation["orderId"];
                        string operationId = (string)operation["operationId"];
                        JObject additionalData = (JObject)operation["additionalData"];
                        string authorizationCode = null;
                        string rrn = null;
                        if(additionalData !=null){
                            authorizationCode = (string)additionalData["authorizationCode"];
                            rrn = (string)additionalData["rrn"];
                        }
                        string paymentEndToEndId = (string)operation["paymentEndToEndId"];
                        string operationTime = (string)operation["operationTime"];
                        string timestampOperation = null;
                        if(operationTime != null) {
                            DateTime npgDateTime = DateTime.Parse(operationTime.Replace(" ","T"));
                            TimeZoneInfo zone = TimeZoneInfo.FindSystemTimeZoneById("Central European Standard Time");
                            DateTime utcDateTime = TimeZoneInfo.ConvertTimeToUtc(npgDateTime, zone);
                            DateTimeOffset dateTimeOffset = new DateTimeOffset(utcDateTime);
                            timestampOperation = dateTimeOffset.ToString("o");
                        }
                        JObject outcomeGateway = new JObject();
                        outcomeGateway["paymentGatewayType"] = "NPG";
                        outcomeGateway["operationResult"] = operationResult;
                        outcomeGateway["orderId"] = orderId;
                        outcomeGateway["operationId"] = operationId;
                        outcomeGateway["authorizationCode"] = authorizationCode;
                        outcomeGateway["paymentEndToEndId"] = paymentEndToEndId;
                        outcomeGateway["rrn"] = rrn;
                        JObject response = new JObject();
                        response["timestampOperation"] = timestampOperation;
                        response["outcomeGateway"] = outcomeGateway;
                        return response.ToString();
                     }
            </set-body>
        </send-request>
        <choose>
            <when condition="@(((int)((IResponse)context.Variables["transactionServiceAuthorizationPatchResponse"]).StatusCode) == 200)">
                <return-response>
                    <set-status code="200" reason="Notification elaborated successfully" />
                </return-response>
            </when>
            <otherwise>
                <return-response>
                    <set-status code="500" reason="Error during transaction status notify" />
                </return-response>
            </otherwise>
        </choose>
        <!-- end send transactions service PATCH request -->
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>
