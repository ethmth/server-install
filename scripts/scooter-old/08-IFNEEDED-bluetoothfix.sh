#!/bin/bash

if [[ $EUID -ne 0 ]]; then
        echo "This script should be run with root/sudo privileges."
        exit 1
fi

#echo "ReverseServiceDiscovery = false" >> /etc/bluetooth/main.conf

grep -q '#ReverseServiceDiscovery' /etc/bluetooth/main.conf && sed -i '/#ReverseServiceDiscovery/a ReverseServiceDiscovery = false' /etc/bluetooth/main.conf

systemctl restart bluetooth
