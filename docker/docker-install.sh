#!/usr/bin/env bash

# Configuration constant: set to 1 to enable location confirmation, 0 to disable
location_confirm=0

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

# Parse the install.root field (defaults to false if not specified)
root_str=$(yq -r '.install.root // false' "$install_yml" 2>/dev/null)

# Convert root string to bash boolean (0 = false, 1 = true)
if [ "$root_str" = "true" ]; then
    root=1
else
    root=0
fi

# Parse the install.my-docker-program field (defaults to false if not specified)
my_docker_program_str=$(yq -r '.install."my-docker-program" // false' "$install_yml" 2>/dev/null)

# Convert my-docker-program string to bash boolean (0 = false, 1 = true)
if [ "$my_docker_program_str" = "true" ]; then
    my_docker_program=1
else
    my_docker_program=0
fi

# Check if root is required based on install.yml
if [ "$root" -eq 1 ]; then
    # Script requires root privileges
    if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
    fi
else
    # Script should not run as root (default)
    if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
    fi
fi

# Parse the install.name field
name=$(yq -r '.install.name' "$install_yml" 2>/dev/null)

# Check if name was successfully parsed
if [ -z "$name" ] || [ "$name" = "null" ]; then
    echo "Error: Name not found in '$install_yml'"
    exit 1
fi

# Parse location (optional)
location=$(yq -r '.install.location' "$install_yml" 2>/dev/null)

# Determine location with confirmation loop
LOC=""
while true; do
    # If location is provided, evaluate it in bash to expand variables
    if [ -n "$location" ] && [ "$location" != "null" ] && [ "$location" != "" ]; then
        # Evaluate the location string to expand $HOME and other variables
        eval "LOC=\"$location\""
    else
        # Prompt user to select location
        LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired $name installation location")
        
        if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
            echo "Nothing was selected. Run this script again with target drive mounted."
            exit 1
        fi
        
        if [ "$LOC" == "/" ]; then
            LOC="$HOME"
        fi
    fi
    
    # Validate location
    if ! [ -d "$LOC" ]; then
        echo "Your location is not available. Is the disk mounted? Do you have access?"
        exit 1
    fi
    
    # Confirm location with user if location_confirm is enabled
    if [ "$location_confirm" -eq 1 ]; then
        echo "Installation location: $LOC"
        read -p "Is this correct? (Y/n): " confirm
        
        # If user confirms (Y, y, or Enter), break the loop
        if [[ "$confirm" =~ ^[Yy]$ ]] || [ -z "$confirm" ]; then
            break
        fi
        
        # If user says no, clear location to force reselection
        location=""
    else
        # Skip confirmation, break the loop
        break
    fi
done


# Set final installation path
LOC="$LOC/docker/$name"
mkdir -p "$LOC"

# Get the directory where install.yml is located
install_dir=$(dirname "$(realpath "$install_yml")")


# Parse and copy files
files=$(yq -r '.install.files[]?' "$install_yml" 2>/dev/null)
if [ -n "$files" ]; then
    while IFS= read -r file; do
        if [ -n "$file" ] && [ "$file" != "null" ]; then
            source_file="$install_dir/$file"
            if [ -d "$source_file" ]; then
                cp -r "$source_file" "$LOC/"
            elif [ -f "$source_file" ]; then
                cp "$source_file" "$LOC/$file"
            fi
        fi
    done <<< "$files"
fi

# Parse and create volumes
volumes=$(yq -r '.install.volumes[]?' "$install_yml" 2>/dev/null)
if [ -n "$volumes" ]; then
    while IFS= read -r vol; do
        if [ -n "$vol" ] && [ "$vol" != "null" ]; then
            mkdir -p "$LOC/$vol"
            chmod -R 777 "$LOC/$vol"
        fi
    done <<< "$volumes"
fi

# Add to .myDockerPrograms if root is false and my-docker-program is true
if [ "$root" -eq 0 ] && [ "$my_docker_program" -eq 1 ]; then
    if ! ( [ -f "$HOME/.myDockerPrograms" ] && ( cat "$HOME/.myDockerPrograms" | grep -q "$LOC" ) ); then
        echo "$LOC" >> "$HOME/.myDockerPrograms"
    fi
fi

echo "Installed $name to $LOC"
echo "Run 'docker-compose up --build -d' to run"
echo "cd $LOC"

# Print custom messages from install.yml if present
messages=$(yq -r '.install.messages[]?' "$install_yml" 2>/dev/null)
if [ -n "$messages" ]; then
    while IFS= read -r msg; do
        if [ -n "$msg" ] && [ "$msg" != "null" ]; then
            echo "$msg"
        fi
    done <<< "$messages"
fi