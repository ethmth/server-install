#!/usr/bin/env bash

if ! [[ $EUID -ne 0 ]]; then
	echo "This script should not be run with root/sudo privileges."
	exit 1
fi
CUR_USER=$(whoami)

# if ! [ -f "my-docker-flag.service" ]; then
#     echo "File doesn't exist."
#     exit 1
# fi

if ! [ -f "my-docker-starter.sh" ]; then
    echo "File doesn't exist."
    exit 1
fi

# sudo cp my-docker-flag.service /etc/systemd/user/my-docker-flag.service

# systemctl --user disable my-docker-flag.service

# sudo sh -c "echo '[Unit]
# Description=Clear marker file in home directory on user startup after boot

# [Service]
# Type=oneshot
# ExecStart=/bin/rm -f /home/$CUR_USER/.myDockerFlag

# [Install]
# WantedBy=default.target' > /etc/systemd/user/my-docker-flag.service"

# systemctl --user enable my-docker-flag.service


sudo cp my-docker-starter.sh /usr/local/bin/my-docker-starter
sudo chmod 755 /usr/local/bin/my-docker-starter

if ! ( cat "/home/$CUR_USER/.bashrc" | grep -q "my-docker-starter" ); then
echo "my-docker-starter" >> /home/$CUR_USER/.bashrc
fi