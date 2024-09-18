#!/bin/bash

# Load the JSON secrets
secrets=$(jq -r '. | to_entries[] | "\(.key)=\(.value)"' "$1")

# Set the environment variables
for secret in $secrets; do
  echo $secret
  IFS='=' read -r key value <<< "$secret"
  export "$key"="$value"
done
