#!/bin/bash

NAME="redis-theatrack"

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

if ! [ -e "./docker-compose.yml" ]; then
	echo "Make sure you run this script in the same directory as ./docker-compose.yml"
	exit 1
fi


# LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired $NAME installation location")

# if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
#     echo "Nothing was selected"
#     echo "Run this script again with target drive mounted."
#     exit 1
# fi

LOC="/"

if [ "$LOC" == "/" ]; then
    LOC="/home/$CUR_USER"
fi

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs"
mkdir -p $LOC

if ! [ -e "$LOC/$NAME" ]; then
mkdir -p $LOC/$NAME
mkdir -p $LOC/$NAME/data
chmod -R 777 $LOC/$NAME/data
fi

cp docker-compose.yml $LOC/$NAME/docker-compose.yml

# cd $LOC/$NAME/

if ( [ -f "/home/$CUR_USER/.myDockerPrograms" ] && ! ( cat "/home/$CUR_USER/.myDockerPrograms" | grep -q "$LOC/$CONTAINER_NAME" ) ); then
    echo "$LOC/$CONTAINER_NAME" >> /home/$CUR_USER/.myDockerPrograms
fi


echo "Run 'docker compose up --build -d' to run it and 'docker compose stop' to stop it from that directory"
echo "cd $LOC/$NAME"
