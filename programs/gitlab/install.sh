#!/bin/bash

CONTAINER_NAME="gitlab"

VOLUMES="
/mnt/cryptdata/encrypted/gitlab/config
/mnt/cryptdata/encrypted/gitlab/logs
/mnt/cryptdata/encrypted/gitlab/data
"

FILES="
docker-compose.yml
"

# Added check
if ! [ -e "docker-compose.yml" ]; then
	echo "Make sure you run this script in the same directory as docker-compose.yml"
	exit 1
fi

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi

# SPECIFIC CHECKS
if mountpoint -q /mnt/cryptdata; then
    if ! [ -d "/mnt/cryptdata/encrypted" ]; then
	    echo "/mnt/cryptdata/encrypted does not exist."
        exit 1
    fi
else
    echo "/mnt/cryptdata is not mounted."
    exit 1
fi

LOC="$HOME"

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
        exit 1
fi

LOC="$LOC/programs"
mkdir -p $LOC/$CONTAINER_NAME

for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/$file
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME
    fi
done

# Modified to use absolute vol
for vol in $VOLUMES; do
    mkdir -p $vol
    chmod -R 777 $vol
done

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker-compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"