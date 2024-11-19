#!/bin/bash

CONTAINER_NAME="postgres"

VOLUMES="
data
"

FILES="
connect.sh
docker-compose.yml
"

if ! [[ $EUID -ne 0 ]]; then
    echo "This script should not be run with root/sudo privileges."
    exit 1
fi
CUR_USER=$(whoami)

# LOC=$(lsblk --noheadings -o MOUNTPOINT | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired $CONTAINER_NAME installation location")

# if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
#     echo "Nothing was selected. Run this script again with target drive mounted."
#     exit 1
# fi

LOC="/"

if [ "$LOC" == "/" ]; then
    LOC="$HOME"
fi

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs"
mkdir -p $LOC/$CONTAINER_NAME

for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME/$file
    fi
done

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

if ( [ -f "/home/$CUR_USER/.myDockerPrograms" ] && ! ( cat "/home/$CUR_USER/.myDockerPrograms" | grep -q "$LOC/$CONTAINER_NAME" ) ); then
    echo "$LOC/$CONTAINER_NAME" >> /home/$CUR_USER/.myDockerPrograms
fi

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run 'docker-compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"
