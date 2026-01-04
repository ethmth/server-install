#!/usr/bin/env bash

# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Error: No install.yml file provided"
    exit 1
fi

install_yml="$1"

# Check if file exists
if [ ! -f "$install_yml" ]; then
    echo "Error: File '$install_yml' does not exist"
    exit 1
fi

# Parse the install.name field
name=$(yq -r '.install.name' "$install_yml" 2>/dev/null)

# Check if name was successfully parsed
if [ -z "$name" ] || [ "$name" = "null" ]; then
    echo "Error: Name not found in '$install_yml'"
    exit 1
fi

# Echo the name if successfully parsed
echo "$name"

