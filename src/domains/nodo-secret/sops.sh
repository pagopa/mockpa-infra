#!/bin/bash

#set -x

action=$1
localenv=$2
shift 2
other=$@

if [ -z "$action" ]; then
helpmessage=$(cat <<EOF
Usage:

./sops.sh d env -> decrypt json file in specified environment
    example: ./sops.sh d weu-dev

./sops.sh s env -> search in enc file per ambiente
    example: ./sops.sh s weu-dev

./sops.sh n env -> crea nuovo file enc json  per ambiente
    example: ./sops.sh n weu-dev

./sops.sh a env -> aggiunge record enc json  per ambiente
    example: ./sops.sh a weu-dev

./sops.sh e env -> edit enc json  per ambiente
    example: ./sops.sh a weu-dev

EOF
)
  echo "$helpmessage"
  exit 0
fi

if [ -z "$localenv" ]; then
  echo "env should be: dev, uat or prod."
  exit 0
fi

source "./secret/$localenv/secret.ini"


if echo "d a s n e" | grep -w $action > /dev/null; then

  azurekvurl=`az keyvault key show --name $prefix-$env_short-$domain-sops-key --vault-name $prefix-$env_short-$domain-kv --query key.kid | sed 's/"//g'`

  
    
    case $action in
      "d")
      
        filesecret="./secret/$localenv/$file_crypted"
        sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted 
        if [ $? -eq 1 ]
        then
          echo "-------------------------------"
          echo "--->>> File $filesecret NON criptato"
          exit 0
        fi
      
      ;;
      "s")
      read -p 'key: ' key
      sops --decrypt --azure-kv $azurekvurl ./secret/$localenv/$file_crypted | grep -i $key
      
      ;;

      "a")
        read -p 'key: ' chiave
        read -p 'valore: ' valore
        sops -i --set  '["'$chiave'"] "'$valore'"' --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
      ;;
      "n")
        if [ -f ./secret/$localenv/$file_crypted ]
        then
          echo "file ./secret/$localenv/$file_crypted già presente"
          exit 0
        else
          echo "{}" > ./secret/$localenv/$file_crypted
          sops --encrypt -i --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
        fi
      ;;
      "e")
        if [ -f ./secret/$localenv/$file_crypted ]
        then
          sops  --azure-kv $azurekvurl ./secret/$localenv/$file_crypted
          
        else
          echo "file ./secret/$localenv/$file_crypted non trovato"
          
        fi
      ;;
    esac
  
else
    echo "Action not allowed."
    exit 1
fi




