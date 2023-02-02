<policies>
    <inbound>
      <base />
       <ip-filter action="forbid">
        <!-- pagopa-p-appgateway-snet  -->
        <address-range from="10.1.128.0" to="10.1.128.255" />
      </ip-filter>
      <set-backend-service base-url="${hostname}" />
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