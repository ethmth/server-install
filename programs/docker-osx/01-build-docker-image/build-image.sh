#!/usr/bin/env bash

IMAGE_NAME="sickcodes/docker-osx:naked"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

if ! [ -f "Dockerfile" ]; then
    echo "Dockerfile doesn't exist. Exiting"
    exit 1
fi

if ! [ -f "Dockerfile.naked" ]; then
    echo "Dockerfile.naked doesn't exist. Exiting"
    exit 1
fi

if docker image inspect $IMAGE_NAME >/dev/null 2>&1; then
    read -p "$IMAGE_NAME exists locally. Do you want to replace it (y/N)? " userInput

    if ([ "$userInput" == "Y" ] || [ "$userInput" == "y" ]); then
        docker rmi "$IMAGE_NAME"
    else
        echo "Exiting. No damage done."
        exit 0
    fi
fi

echo "If you're having build issues downloading something, try turning VPN off."
docker build -t "sickcodes/docker-osx:latest" .

docker build -t "sickcodes/docker-osx:naked" -f Dockerfile.naked .
