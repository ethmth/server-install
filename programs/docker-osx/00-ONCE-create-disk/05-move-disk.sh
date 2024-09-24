#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

if ! [ -f "working_disk/mac_hdd_ng.img" ]; then
    echo "working_disk/mac_hdd_ng.img doesn't exist. Exiting"
    exit 1
fi

if [ -f "disk_here/mac_hdd_ng.img" ]; then
    echo "disk_here/mac_hdd_ng.img already exists. Remove it to continue. (BE SURE)"
    exit 1
fi

mv working_disk/mac_hdd_ng.img disk_here/mac_hdd_ng.img