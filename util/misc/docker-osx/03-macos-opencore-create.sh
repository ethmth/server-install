#!/bin/bash

MODEL_TO_REPLACE="iMacPro1,1"
SERIAL_TO_REPLACE="C02TM2ZBHX87"
BOARD_SERIAL_TO_REPLACE="C02717306J9JG361M"
UUID_TO_REPLACE="007076A6-F2A2-4461-BBE5-BAD019F8025A"
ROM_TO_REPLACE="m7zhIYfl"

if ! [[ $EUID -ne 0 ]]; then
        echo "This script should not be run with root/sudo privileges."
        exit 1
fi

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}")
cd $SCRIPT_RELATIVE_DIR
ABSOLUTE_PATH=$(pwd)

CUR_USER=$(whoami)

LOC="/home/$CUR_USER/programs/docker-osx"
mkdir -p $LOC
cd $LOC

if ! [ -e "$LOC/values.conf" ]; then
    echo "values.conf doesn't exist"
    exit 1
fi

source $LOC/values.conf

if [ -e "$LOC/osx-serial-generator" ]; then
    cd osx-serial-generator
fi

git clone --depth 1 --recurse-submodules https://github.com/kholia/OSX-KVM.git OSX-KVM
cd OSX-KVM/OpenCore

if ! [ -e "$ABSOLUTE_PATH/config.plist" ]; then
    echo "config.plist template doesn't exist in $ABSOLUTE_PATH"
    exit 1
fi

cp $ABSOLUTE_PATH/config.plist config.plist

sed -i "s/$MODEL_TO_REPLACE/$MODEL/g" config.plist
sed -i "s/$SERIAL_TO_REPLACE/$SERIAL/g" config.plist
sed -i "s/$BOARD_SERIAL_TO_REPLACE/$BOARD_SERIAL/g" config.plist
sed -i "s/$UUID_TO_REPLACE/$UUID/g" config.plist
sed -i "s/$ROM_TO_REPLACE/$ROM/g" config.plist

rm OpenCore.qcow2
./opencore-image-ng.sh --cfg config.plist --img OpenCore.qcow2

cd $LOC
mv $LOC/osx-serial-generator/OSX-KVM/OpenCore/OpenCore.qcow2 .

cd $LOC/osx-serial-generator/OSX-KVM
git restore OVMF_VARS.fd

echo "OpenCore.qcow2 created at $LOC/OpenCore.qcow2"
echo "To edit/check config.plist inside the OpenCore image, run:"
echo "EDITOR=vim virt-edit -m /dev/sda1 $LOC/OpenCore.qcow2 /EFI/OC/config.plist"
