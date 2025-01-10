xpack.security.authc.realms.saml.${realm_name}:
            order: 2
            attributes.principal: nameid
            attributes.groups: "http://schemas.microsoft.com/ws/2008/06/identity/claims/groups"
            idp.metadata.path: "https://login.microsoftonline.com/${tenant_id}/federationmetadata/2007-06/federationmetadata.xml?appid=${application_id}"
            idp.entity_id: "https://sts.windows.net/${tenant_id}/"
            sp.entity_id: "${kibana_url}"
            sp.acs: "${kibana_url}/api/security/saml/callback"
            sp.logout: "${kibana_url}/logout"
