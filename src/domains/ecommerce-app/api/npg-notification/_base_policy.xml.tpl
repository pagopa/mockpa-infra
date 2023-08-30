<policies>
    <inbound>
        <cors>
            <allowed-origins>
                <origin>*</origin>
            </allowed-origins>
            <allowed-methods>
                <method>*</method>
            </allowed-methods>
            <allowed-headers>
                <header>*</header>
            </allowed-headers>
            <expose-headers>
                <header>*</header>
            </expose-headers>
        </cors>
        <set-variable name="donazioniucraina" value="{{donazioni-ucraina}}" />
        <set-variable name="donazioniucraina2" value="{{donazioni-ucraina2}}" />
        <set-variable name="envshort" value="${env_short}" />
        <set-variable name="logo1" value="${logo_1}" />
        <set-variable name="logo2" value="${logo_2}" />
        <set-variable name="logo3" value="${logo_3}" />
        <set-variable name="logo4" value="${logo_4}" />
        <set-variable name="logo5" value="${logo_5}" />
        <set-variable name="logo6" value="${logo_6}" />


        <!-- logo7 start ActionAid -->
        <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="false" />
        <send-request mode="new" response-variable-name="logoresult" timeout="300" ignore-error="false">
            <set-url>@(String.Format("https://pagopa{0}logosdonationsa.blob.core.windows.net/{1}/{2}", (string)context.Variables["envshort"], String.Format("pagopa{0}logosdonationsalogo7", (string)context.Variables["envshort"]), "logo7"))</set-url>
            <set-method>GET</set-method>
            <set-header name="Host" exists-action="override">
                <value>@(String.Format("pagopa{0}logosdonationsa.blob.core.windows.net", (string)context.Variables["envshort"]))</value>
            </set-header>
            <set-header name="X-Ms-Blob-Type" exists-action="override">
                <value>BlockBlob</value>
            </set-header>
            <set-header name="X-Ms-Blob-Cache-Control" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Disposition" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Encoding" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Language" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Version" exists-action="override">
                <value>2019-12-12</value>
            </set-header>
            <set-header name="Accept" exists-action="override">
                <value>application/json</value>
            </set-header>
            <!-- Set the header with authorization bearer token that was previously requested -->
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
            </set-header>
        </send-request>
        <set-variable name="logo7" value="@(((IResponse)context.Variables["logoresult"]).Body.As<String>(preserveContent: true).ToString())" />
        <!-- logo7 stop -->
        <!-- logo8 start INTERSOS -->
        <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="false" />
        <send-request mode="new" response-variable-name="logoresult" timeout="300" ignore-error="false">
            <set-url>@(String.Format("https://pagopa{0}logosdonationsa.blob.core.windows.net/{1}/{2}", (string)context.Variables["envshort"], String.Format("pagopa{0}logosdonationsalogo8", (string)context.Variables["envshort"]), "logo8"))</set-url>
            <set-method>GET</set-method>
            <set-header name="Host" exists-action="override">
                <value>@(String.Format("pagopa{0}logosdonationsa.blob.core.windows.net", (string)context.Variables["envshort"]))</value>
            </set-header>
            <set-header name="X-Ms-Blob-Type" exists-action="override">
                <value>BlockBlob</value>
            </set-header>
            <set-header name="X-Ms-Blob-Cache-Control" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Disposition" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Encoding" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Language" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Version" exists-action="override">
                <value>2019-12-12</value>
            </set-header>
            <set-header name="Accept" exists-action="override">
                <value>application/json</value>
            </set-header>
            <!-- Set the header with authorization bearer token that was previously requested -->
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
            </set-header>
        </send-request>
        <set-variable name="logo8" value="@(((IResponse)context.Variables["logoresult"]).Body.As<String>(preserveContent: true).ToString())" />
        <!-- logo8 stop -->
        <!-- logo9 start MFS -->
        <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="false" />
        <send-request mode="new" response-variable-name="logoresult" timeout="300" ignore-error="false">
            <set-url>@(String.Format("https://pagopa{0}logosdonationsa.blob.core.windows.net/{1}/{2}", (string)context.Variables["envshort"], String.Format("pagopa{0}logosdonationsalogo9", (string)context.Variables["envshort"]), "logo9"))</set-url>
            <set-method>GET</set-method>
            <set-header name="Host" exists-action="override">
                <value>@(String.Format("pagopa{0}logosdonationsa.blob.core.windows.net", (string)context.Variables["envshort"]))</value>
            </set-header>
            <set-header name="X-Ms-Blob-Type" exists-action="override">
                <value>BlockBlob</value>
            </set-header>
            <set-header name="X-Ms-Blob-Cache-Control" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Disposition" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Encoding" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Language" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Version" exists-action="override">
                <value>2019-12-12</value>
            </set-header>
            <set-header name="Accept" exists-action="override">
                <value>application/json</value>
            </set-header>
            <!-- Set the header with authorization bearer token that was previously requested -->
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
            </set-header>
        </send-request>
        <set-variable name="logo9" value="@(((IResponse)context.Variables["logoresult"]).Body.As<String>(preserveContent: true).ToString())" />
        <!-- logo9 stop -->
        <!-- logo10 start UNICEF -->
        <authentication-managed-identity resource="https://storage.azure.com/" output-token-variable-name="msi-access-token" ignore-error="false" />
        <send-request mode="new" response-variable-name="logoresult" timeout="300" ignore-error="false">
            <set-url>@(String.Format("https://pagopa{0}logosdonationsa.blob.core.windows.net/{1}/{2}", (string)context.Variables["envshort"], String.Format("pagopa{0}logosdonationsalogo10", (string)context.Variables["envshort"]), "logo10"))</set-url>
            <set-method>GET</set-method>
            <set-header name="Host" exists-action="override">
                <value>@(String.Format("pagopa{0}logosdonationsa.blob.core.windows.net", (string)context.Variables["envshort"]))</value>
            </set-header>
            <set-header name="X-Ms-Blob-Type" exists-action="override">
                <value>BlockBlob</value>
            </set-header>
            <set-header name="X-Ms-Blob-Cache-Control" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Disposition" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Encoding" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Blob-Content-Language" exists-action="override">
                <value />
            </set-header>
            <set-header name="X-Ms-Version" exists-action="override">
                <value>2019-12-12</value>
            </set-header>
            <set-header name="Accept" exists-action="override">
                <value>application/json</value>
            </set-header>
            <!-- Set the header with authorization bearer token that was previously requested -->
            <set-header name="Authorization" exists-action="override">
                <value>@("Bearer " + (string)context.Variables["msi-access-token"])</value>
            </set-header>
        </send-request>
        <set-variable name="logo10" value="@(((IResponse)context.Variables["logoresult"]).Body.As<String>(preserveContent: true).ToString())" />
        <!-- logo10 stop -->

        <return-response>
            <set-status code="200" reason="OK" />
            <set-header name="Content-Type" exists-action="override">
                <value>application/json</value>
            </set-header>
            <set-body>@{
                var donazioniucraina = ((string) context.Variables["donazioniucraina"]);
                JObject json = JObject.Parse(donazioniucraina);
                var idx=1;
                foreach (var item1 in json["data"])
                {
                    var auxdigit = (string)((JObject) item1)["auxdigit"];
                    var segregationcode = (string)((JObject) item1)["segregationcode"];

                    ((JObject) item1).Remove("iban"); // del property
                    ((JObject) item1).Remove("auxdigit"); // del property
                    ((JObject) item1).Remove("segregationcode"); // del property
                    ((JObject) item1)["base64Logo"]=(string) context.Variables["logo"+idx];
                    idx++;

                    foreach (var item2 in ((JObject) item1)["slices"])
                    {
                        var iuv = DateTimeOffset.Now.ToUnixTimeMilliseconds().ToString();
                        var nav = auxdigit+segregationcode+((JObject) item2)["idDonation"]+iuv;
                        ((JObject) item2).Add(new JProperty("nav",nav)); // add property
                        // ((JObject) item2).Add("nav", JObject.Parse(@"{""colour"":""yellow"",""size"":""medium""}"));
                    }
                }

                // DONATIONs step-2
                var donazioniucraina2 = ((string) context.Variables["donazioniucraina2"]);
                JObject json2 = JObject.Parse(donazioniucraina2);
                var idx2=7;
                foreach (var item1 in json2["data"])
                {
                    var auxdigit = (string)((JObject) item1)["auxdigit"];
                    var segregationcode = (string)((JObject) item1)["segregationcode"];

                    ((JObject) item1).Remove("iban"); // del property
                    ((JObject) item1).Remove("auxdigit"); // del property
                    ((JObject) item1).Remove("segregationcode"); // del property
                    ((JObject) item1)["base64Logo"]=(string) context.Variables["logo"+idx2];
                    idx2++;

                    foreach (var item2 in ((JObject) item1)["slices"])
                    {
                        var iuv = DateTimeOffset.Now.ToUnixTimeMilliseconds().ToString();
                        var nav = auxdigit+segregationcode+((JObject) item2)["idDonation"]+iuv;
                        ((JObject) item2).Add(new JProperty("nav",nav)); // add property
                        // ((JObject) item2).Add("nav", JObject.Parse(@"{""colour"":""yellow"",""size"":""medium""}"));
                    }
                }        

                // Union sequence

                foreach (var item1 in json2["data"])
                {
                    (json["data"] as JArray).Add(item1);
                }
                
                // order by companyName ASC
                json["data"] = new JArray((json["data"] as JArray).OrderBy(obj => (string)obj["name"]));

                return json["data"].ToString();

             }</set-body>
        </return-response>
        <base />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound />
    <on-error>
        <base />
    </on-error>
</policies>
