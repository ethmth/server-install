#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This script should be run with root/sudo privileges."
	exit 1
fi

dd if=/dev/urandom of=/opt/encrypted_container bs=1M count=10240

cryptsetup -y luksFormat /opt/encrypted_container

file /opt/encrypted_container

cryptsetup luksOpen /opt/encrypted_container cryptdata

mkfs.ext4 -j /dev/mapper/cryptdata

mkdir -p /mnt/cryptdata

mount /dev/mapper/cryptdata /mnt/cryptdata

chmod -R 777 /mnt/cryptdata

echo '#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This script should be run with root/sudo privileges."
	exit 1
fi
cryptsetup luksOpen /opt/encrypted_container cryptdata
mkdir -p /mnt/cryptdata
mount /dev/mapper/cryptdata /mnt/cryptdata
if mountpoint -q /mnt/cryptdata; then
	mkdir -p /mnt/cryptdata/encrypted
fi' > /usr/local/bin/cryptmount
chmod +rx /usr/local/bin/cryptmount

