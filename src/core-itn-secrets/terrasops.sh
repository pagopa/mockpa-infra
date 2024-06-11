#!/bin/bash
# set -x  # Uncomment this line to enable debug mode

eval "$(jq -r '@sh "export terrasops_env=\(.env)"')"

# shellcheck disable=SC1090
source "./secret/$terrasops_env/secret.ini"
encrypted_file_path="./secret/$terrasops_env/$file_crypted"

if [ -f "$encrypted_file_path" ]; then
  # Load the values of azure_kv.vault_url and azure_kv.name from the JSON file
  azure_kv_vault_url=$(jq -r '.sops.azure_kv[0].vault_url' "$encrypted_file_path")
  azure_kv_name=$(jq -r '.sops.azure_kv[0].name' "$encrypted_file_path")

  if [ -z "$azure_kv_vault_url" ] || [ -z "$azure_kv_name" ]; then
    echo "❌ Error: Unable to load the values of azure_kv.vault_url and azure_kv.name from the JSON file" >&2
    exit 1
  fi
  sops -d --azure-kv "azure_kv_vault_url" "$encrypted_file_path" | jq -c
else
  echo "{}" | jq -c
fi
