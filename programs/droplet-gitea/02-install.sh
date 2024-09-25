#!/bin/bash

CONTAINER_NAME="gitea"

VOLUMES="
"

ABS_VOLUMES="
/mnt/cryptdata/encrypted/gitea/data
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
for vol in $ABS_VOLUMES; do
    sudo mkdir -p $vol
    sudo chmod -R 777 $vol
done

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

if ! ( [ -f "/home/$CUR_USER/.myDockerPrograms" ] && ( cat "/home/$CUR_USER/.myDockerPrograms" | grep -q "$LOC/$CONTAINER_NAME" ) ); then
    echo "$LOC/$CONTAINER_NAME" >> /home/$CUR_USER/.myDockerPrograms
fi

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker-compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"