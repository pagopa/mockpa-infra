#!/bin/bash

#set -x
eval "$(jq -r '@sh "export terrasops_env=\(.env)"')"

source "./secret/$terrasops_env/secret.ini"

azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid | sed 's/"//g'`
sops -d  --azure-kv $azurekvurl ./secret/$terrasops_env/$file_crypted | jq -c


