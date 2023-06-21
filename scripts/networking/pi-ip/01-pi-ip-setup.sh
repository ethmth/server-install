#!/bin/bash

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

CUR_USER=$(whoami)

mkdir -p /home/$CUR_USER/scripts
git clone https://github.com/ethmth/pi-ip /home/$CUR_USER/scripts/pi-ip
cp /home/$CUR_USER/scripts/pi-ip/.env.example /home/$CUR_USER/scripts/pi-ip/.env

chmod +x /home/$CUR_USER/scripts/pi-ip/ipcheck.sh

echo "*/1 * * * * /home/$CUR_USER/scripts/pi-ip/ipcheck.sh" > /home/$CUR_USER/scripts/pi-ip/crontab.txt
echo "@reboot /home/$CUR_USER/scripts/pi-ip/ipcheck.sh startup" >> /home/$CUR_USER/scripts/pi-ip/crontab.txt

crontab /home/$CUR_USER/scripts/pi-ip/crontab.txt

echo "Edit the /home/$CUR_USER/scripts/pi-ip/.env file with the correct values."
echo "vim /home/$CUR_USER/scripts/pi-ip/.env"
echo "Then, reboot."
