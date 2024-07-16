<policies>
    <inbound>
    <base />
    <choose>
      <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}") )"> 
        <include-fragment fragment-id="pm-chk-wallet-session" />
      </when>
    </choose>
    </inbound>
    <outbound>
      <base />
      <choose>
        <when condition="@("true".Equals("{{enable-pm-ecommerce-io}}"))">
          <set-body>@{
            JObject response = context.Response.Body.As<JObject>();

            if (context.Response.StatusCode != 200) {
              return response.ToString();
            }

            string enabled_payment_wallet_method_ids_pm = "${enabled_payment_wallet_method_ids_pm}";
            string[] values = enabled_payment_wallet_method_ids_pm.Split(',');
            HashSet<string> pmEnabledMethods = new HashSet<string>(values);

            foreach (var method in ((JArray) response["paymentMethods"])) {
              string id = (string) method["id"];
              if (pmEnabledMethods.Contains(id)) {
                method["status"] = "ENABLED";
                method["methodManagement"] = "ONBOARDABLE_ONLY";
              } else {
                method["status"] = "DISABLED";
              }
            }

            return response.ToString();
          }
          </set-body>
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
