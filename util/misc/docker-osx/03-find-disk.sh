#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

images=$(find /var/lib/docker | grep "mac_hdd_ng.img")

threshold_bytes=$((15 * 1024 * 1024 * 1024))

target_image=""
for image in $images; do
    output=$(qemu-img info $image)
   
    file_length_line=$(echo "$output" | grep 'file length:')
    file_length_bytes=$(echo "$file_length_line" | awk -F'[()]' '{print $2}')
    file_length_bytes="${file_length_bytes// bytes}"

    # echo "$output"
    # echo "File Length in Bytes: $file_length_bytes"

    if [ "$file_length_bytes" -gt "$threshold_bytes" ]; then
        # echo "File Length is greater than 15 GB"
        target_image=$image
        break
    # else
    #     echo "File Length is NOT greater than 15 GB"
    fi

    # echo "====================================================="
done

if [ "$target_image" == "" ]; then
    echo "No target image found."
    exit 1
fi

echo "The target image is $target_image"
qemu-img info $target_image