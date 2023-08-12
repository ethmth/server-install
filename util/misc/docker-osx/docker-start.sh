#!/bin/bash

docker run \
  --rm \
  --name bluebubbles \
  --device /dev/kvm \
  -p 5999:5999 \
  -p 1234:1234 \
  -p 1359:1359 \
  -p 50922:10022 \
  -v ./mac_hdd_ng.img:/image \
#   -v ./OpenCore.qcow2:/bootdisk \
  -e AUDIO_DRIVER=none \
  -e IMAGE_PATH="/image" \
#   -e BOOTDISK="/bootdisk" \
  -e EXTRA="-display none -vnc 0.0.0.0:99,password-secret=secvnc0 -object secret,id=secvnc0,data=vncpass" \
  -e ADDITIONAL_PORTS="hostfwd=tcp::1234-:1234,hostfwd=tcp::1359-:1359," \
#   -e DISPLAY=:99 \
  -e WIDTH=1280 \
  -e HEIGHT=720 \
#   -e NOPICKER=true \
  sickcodes/docker-osx:naked


docker run -it \
    -v "./mac_hdd_ng.img:/image" \
    --device /dev/kvm \
    -p 5999:5999 \
    -p 50922:10022 \
    -e NOPICKER=true \
    -e GENERATE_SPECIFIC=true \
    -e AUDIO_DRIVER=none \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e EXTRA="-display none -vnc 0.0.0.0:99,password-secret=secvnc0 -object secret,id=secvnc0,data=vncpass" \
    -e ADDITIONAL_PORTS="hostfwd=tcp::1234-:1234,hostfwd=tcp::1359-:1359," \
    -e WIDTH=1280 \
    -e HEIGHT=720 \
    sickcodes/docker-osx:naked

# run an existing image in current directory, with a screen, with SSH, with nopicker.

stat mac_hdd_ng.img # make sure you have an image if you're using :naked

docker run -it \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    --device /dev/kvm \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -e NOPICKER=true \
    -e GENERATE_SPECIFIC=true \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e WIDTH=1000 \
    -e HEIGHT=1000 \
    sickcodes/docker-osx:naked