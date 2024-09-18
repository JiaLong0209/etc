#!/bin/bash

# Get the directory where the script is located
script_dir=$(dirname "$0")

# Loop through all .sh files in the script's directory
for file in "$script_dir"/*.sh; do
  # Check if the file exists and is a regular file
  if [[ -f "$file" ]]; then
    # Change the file permission to make it executable
    chmod 755 "$file"
    echo "Made $file executable."
  else
    echo "No .sh files found in the script's directory."
  fi
done
