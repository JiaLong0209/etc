#!/bin/bash

# Load the JSON secrets from the argument
secrets=($(echo "$1" | jq '. | to_entries[] | "\(.key)=\(.value)"'))
# echo "${secrets[@]}"

# Set the environment variables
for secret in "${secrets[@]}"; do
  key=$(echo "$secret" | cut -d '=' -f 1)
  value=$(echo "$secret" | cut -d '=' -f 2-)
  eval "export $key=\"$value\""
done
