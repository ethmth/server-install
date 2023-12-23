#!/bin/bash

CONTAINER_NAME="nginx"

VOLUMES="
html
conf.d
certbot
"

FILES="
docker-compose.yml
Dockerfile
nginx.conf
conf.d
html
init-letsencrypt.sh
"

if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

CUR_USER=$(whoami)
LOC="/opt"

read -p "Please enter your domain (or subdomain): " new_domain
if [ "$new_domain" == "" ]; then
    echo "Please specify your domain next time."
    exit 1
fi

mkdir -p $LOC/$CONTAINER_NAME

for file in $FILES; do
    if [ -d "$file" ]; then
        cp -r $file $LOC/$CONTAINER_NAME/$file

        for myfile in "$LOC/$CONTAINER_NAME/$file"/*; do
            if [ -f "$myfile" ]; then
                sed -i "s/YOURDOMAIN\.COM/$new_domain/g" "$myfile"
            fi
        done
    elif [ -f "$file" ]; then
        cp $file $LOC/$CONTAINER_NAME/$file
        sed -i "s/YOURDOMAIN\.COM/$new_domain/g" "$LOC/$CONTAINER_NAME/$file"
    fi
done

chmod +rx $LOC/$CONTAINER_NAME/init-letsencrypt.sh

for vol in $VOLUMES; do
    mkdir -p $LOC/$CONTAINER_NAME/$vol
    chmod -R 777 $LOC/$CONTAINER_NAME/$vol
done

echo "Installed $CONTAINER_NAME to $LOC"
echo "Run './init-letsencrypt.sh' to start, then 'sudo docker-compose up --build -d' to run"
echo "cd $LOC/$CONTAINER_NAME"