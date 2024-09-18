#!/bin/bash

# Define the directory path
DIR_PATH=$1

# Expand the tilde (~) to the full path
DIR_PATH=$(eval echo $DIR_PATH)

# Check if the directory exists
if [ -d "$DIR_PATH" ]; then 
    echo "Directory '$DIR_PATH' already exists."
else 
    # Create the directory if it does not exist
    mkdir -p "$DIR_PATH"
    if [ $? -eq 0 ]; then
        echo "Directory '$DIR_PATH' has been created."
    else
        echo "Failed to create directory '$DIR_PATH'."
        exit 1
    fi
fi

# Find and list all .sh files
for script in $(find . -type f -iname "*.sh"); do 
    echo "$script"
done

# Copy all .sh files to the target directory
cp $(find . -type f -iname "*.sh") "$DIR_PATH"

# Check if the copy operation was successful
if [ $? -eq 0 ]; then
    echo "All .sh files have been copied to '$DIR_PATH'."
else
    echo "Failed to copy .sh files to '$DIR_PATH'."
    exit 1
fi
