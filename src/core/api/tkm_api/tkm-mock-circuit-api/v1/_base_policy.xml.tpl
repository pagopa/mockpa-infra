<policies>
    <inbound>
      <base />
      <set-backend-service base-url="http://{{aks-lb-nexi}}:80" />
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