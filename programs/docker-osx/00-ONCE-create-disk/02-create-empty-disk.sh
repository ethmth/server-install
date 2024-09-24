#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "$SCRIPT_DIR"

if [ -d "working_disk" ]; then
    echo "working_disk/ exists. Remove it to continue."
    exit 1
fi

mkdir working_disk
# dd if=/dev/zero of=working_disk/mac_hdd_ng.img iflag=fullblock bs=1M count=20000 && sync

qemu-img create -f qcow2 working_disk/mac_hdd_ng.img 32G