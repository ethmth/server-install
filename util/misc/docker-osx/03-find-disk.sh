#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

images=$(find /var/lib/docker | grep "mac_hdd_ng.img")

for image in $images; do
    qemu-img info $image
done

