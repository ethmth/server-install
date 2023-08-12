#!/bin/bash

DISK_SIZE="30"

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

qemu-img create -f qcow2 "mac_hdd_ng_auto.img" "${DISK_SIZE}G"

echo "Disk mac_hdd_ng_auto.img created."
