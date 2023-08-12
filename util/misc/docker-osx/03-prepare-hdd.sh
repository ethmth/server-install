#!/bin/bash

# username is user
# passsword is alpine


if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

# CUR_USER=$(whoami)

# LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired installation location")

# if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
#     echo "Nothing was selected"
#     echo "Run this script again with target drive mounted."
#     exit 1
# fi

# if [ "$LOC" == "/" ]; then
#     LOC="/home/$CUR_USER"
# fi

# if ! [ -d "$LOC" ]; then
#     echo "Your location is not available. Is the disk mounted? Do you have access?"
# 	exit 1
# fi

# LOC="$LOC/programs/docker-osx"
# mkdir -p $LOC
# cd $LOC

docker pull sickcodes/docker-osx:auto

# id=$(docker create sickcodes/docker-osx:auto)
# docker cp $id:/home/arch/OSX-KVM/mac_hdd_ng.img - > mac_hdd_ng.img
# docker rm -v $id

echo "==========================================="
echo "I am going to run the docker container."
# echo "Wait until the container shows QEMU or ALSA messages, then stop the container"
echo "Wait until you get an ssh shell into the machine, then shutdown using"
echo "'sudo shutdown -h now' with password 'alpine'"
echo "Then, run the next script."
read -p "Press anything to continue: " userInput
echo "==========================================="

docker run -it \
    --name dockerosx_imageextractor \
    --device /dev/kvm \
    -p 50922:10022 \
    sickcodes/docker-osx:auto