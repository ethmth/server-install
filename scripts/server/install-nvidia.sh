#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

# sed -i '/^deb/ {/non-free-firmware/! s/$/ non-free-firmware/}' /etc/apt/sources.list

# echo "Explanation: Disable packages from non-free tree by default
# Package: *
# Pin: release o=Debian,a=stable,l=Debian,c=non-free
# Pin-Priority: -1" > /etc/apt/preferences.d/non-free_policy

# echo "Explanation: Enable package firmware-realtek from non-free tree
# Package: firmware-realtek
# Pin: release o=Debian,a=stable,l=Debian,c=non-free
# Pin-Priority: 600" > /etc/apt/preferences.d/firmware-realtek_nonfree

# add-apt-repository contrib non-free-firmware

# apt update && apt install linux-headers-amd64 -y

# curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3df863cc.pub | gpg --dearmor | tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1

curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | gpg --dearmor | tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | tee /etc/apt/sources.list.d/nvidia-drivers.list

apt update

apt install nvidia-driver nvidia-driver-cuda nvidia-settings