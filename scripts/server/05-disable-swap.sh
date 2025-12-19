#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
    echo "This script should be run with root/sudo privileges."
    exit 1
fi

partition=$(echo "$(lsblk --list -f -o NAME,MOUNTPOINT | grep -v "loop" | grep "SWAP" | awk '{print $1}')" | fzf --prompt="Please select the SWAP partition.")
if [ "$partition" == "" ]; then
  echo "Partition not selected."
  exit 1
fi
partition="/dev/$partition"

if ! [ -e "$partition" ]; then
    echo "$partition doesn't exist."
    exit 1
fi

free -h

swapoff "$partition"

free -h

# Remove it from fstab
sed -i '/swap/s/^/#/' /etc/fstab

device=$(echo "$partition" | cut -d'/' -f3)
systemctl mask dev-$device.swap