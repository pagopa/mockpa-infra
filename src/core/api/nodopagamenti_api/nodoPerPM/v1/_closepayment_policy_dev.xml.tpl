<policies>
    <inbound>
        <base />
        <set-backend-service base-url="{{default-nodo-backend-dev-nexi}}/v1" />
    </inbound>
    <backend>
        <base />
    </backend>
    <outbound>
        <base />
    </outbound>
    <on-error>
        <base />
    </on-error>
</policies>
