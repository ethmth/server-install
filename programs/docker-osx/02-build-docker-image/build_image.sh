#!/usr/bin/env bash

IMAGE_NAME="sickcodes/docker-osx:naked"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if docker image inspect $IMAGE_NAME >/dev/null 2>&1; then
    read -p "$IMAGE_NAME exists locally. Do you want to replace it (y/N)? " userInput

    if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
        docker rmi "$IMAGE_NAME"
    else
        echo "Exiting. No damage done."
        exit 0
    fi
fi

cd "$SCRIPT_DIR"

if [ -d "Docker-OSX" ]; then
    rm -rf "Docker-OSX"
fi

git clone https://github.com/sickcodes/Docker-OSX.git
cd Docker-OSX
rm -rf .git
docker build -t "sickcodes/docker-osx:latest" .

cp Dockerfile.naked Dockerfile

docker build -t "sickcodes/docker-osx:naked" .
