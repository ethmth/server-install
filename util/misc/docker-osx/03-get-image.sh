#!/bin/bash

# username is user
# passsword is alpine


if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

LOC=$(lsblk --noheadings -o MOUNTPOINTS | grep -v '^$' | grep -v "/boot" | fzf --prompt="Select your desired installation location")

if ([ "$LOC" == "" ] || [ "$LOC" == "Cancel" ]); then
    echo "Nothing was selected"
    echo "Run this script again with target drive mounted."
    exit 1
fi

if [ "$LOC" == "/" ]; then
    LOC="/home/$CUR_USER"
fi

if ! [ -d "$LOC" ]; then
    echo "Your location is not available. Is the disk mounted? Do you have access?"
	exit 1
fi

LOC="$LOC/programs/docker-osx"
mkdir -p $LOC
cd $LOC

docker pull sickcodes/docker-osx:auto

images=$(sudo find /var/lib/docker | grep "mac_hdd_ng.img")

threshold_bytes=$((15 * 1024 * 1024 * 1024))

target_image=""
for image in $images; do
    output=$(sudo qemu-img info $image)
   
    file_length_line=$(echo "$output" | grep 'file length:')
    file_length_bytes=$(echo "$file_length_line" | awk -F'[()]' '{print $2}')
    file_length_bytes="${file_length_bytes// bytes}"

    if [ "$file_length_bytes" -gt "$threshold_bytes" ]; then
        target_image=$image
        break
    fi
done

if [ "$target_image" == "" ]; then
    echo "No target image found."
    exit 1
fi

sudo cp $target_image mac_hdd_ng.img