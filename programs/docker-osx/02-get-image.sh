#!/bin/bash

# username is user
# passsword is alpine


if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

# LOC="/home/$CUR_USER/programs/docker-osx"
# mkdir -p $LOC
# cd $LOC

# read -p "Do you want to pull a new image (Y/n)? " userInput
# if ([ "$userInput" == "n" ] || [ "$userInput" == "N" ]); then
#     echo "Using existing image."
# else
#     # docker pull sickcodes/docker-osx:auto@sha256:412022bd79ebc98e5a6ec87601db9dc625fbea76443b54d0acaabf6f228e5652
#     docker pull sickcodes/docker-osx:auto
#     yes | docker system prune
# fi

# images=$(sudo find /var/lib/docker | grep "mac_hdd_ng.img")

# threshold_bytes=$((15 * 1024 * 1024 * 1024))

# target_image=""
# for image in $images; do
#     output=$(sudo qemu-img info $image)
   
#     disk_size=$(echo "$output" | grep "disk size:" | awk '{print $3}' | head -n 1)
#     disk_unit=$(echo "$output" | grep "disk size:" | awk '{print $4}' | head -n 1)

#     disk_size=$(echo "$disk_size" | awk -F'.' '{print $1}')

#     disk_size_bytes="0"
#     if [ "$disk_unit" = "KiB" ]; then
#         disk_size_bytes=$((disk_size * 1024))
#     elif [ "$disk_unit" = "MiB" ]; then
#         disk_size_bytes=$((disk_size * 1024 * 1024))
#     elif [ "$disk_unit" = "GiB" ]; then
#         disk_size_bytes=$((disk_size * 1024 * 1024 * 1024))
#     fi

#     if [ "$disk_size_bytes" -gt "$threshold_bytes" ]; then
#         target_image=$image
#         break
#     fi
# done

# if [ "$target_image" == "" ]; then
#     echo "No target image found."
#     exit 1
# fi

if ! [ -f "00-ONCE-create-disk/disk_here/mac_hdd_ng.img" ]; then
    echo "00-ONCE-create-disk/disk_here/mac_hdd_ng.img doesn't exist."
    echo "Go through the 00-ONCE-create-disk creation process."
    exit 1
fi

LOC="/home/$CUR_USER/programs/docker-osx"
mkdir -p $LOC

cp 00-ONCE-create-disk/disk_here/mac_hdd_ng.img /home/$CUR_USER/programs/docker-osx/mac_hdd_ng.img

qemu-img resize /home/$CUR_USER/programs/docker-osx/mac_hdd_ng.img +20G