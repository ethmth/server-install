#!/bin/bash

CONTAINER_NAME="pihole"

VOLUMES="
etc-pihole
etc-dnsmasq.d
"

FILES="
docker-compose.yml
"

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

# LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired $CONTAINER_NAME installation location")

# if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
#     echo "Nothing was selected. Run this script again with target drive mounted."
#     exit 1
# fi

# if [ "$LOC" == "/" ]; then
#     LOC="/opt"
# fi
LOC="/opt"

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs"
sudo mkdir -p $LOC/$CONTAINER_NAME
sudo chmod 777 "$LOC"
sudo chmod 777 "$LOC/$CONTAINER_NAME"


for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/
        sudo chmod 777 $LOC/$CONTAINER_NAME/$file
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME/$file
        sudo chmod 666 $LOC/$CONTAINER_NAME/$file
    fi
done

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker-compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"