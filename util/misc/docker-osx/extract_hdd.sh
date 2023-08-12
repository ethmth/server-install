#!/bin/bash

docker pull sickcodes/docker-osx:auto

id=$(docker create sickcodes/docker-osx:auto)
docker cp $id:/home/arch/OSX-KVM/mac_hdd_ng.img - > mac_hdd_ng.img
docker rm -v $id
