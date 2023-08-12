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
  -v ./OpenCore.qcow2:/bootdisk \
  -e IMAGE_PATH="/image" \
  -e BOOTDISK="/bootdisk" \
  -e EXTRA="-display none -vnc 0.0.0.0:99,password-secret=secvnc0 -object secret,id=secvnc0,data=vncpass" \
  -e ADDITIONAL_PORTS="hostfwd=tcp::1234-:1234,hostfwd=tcp::1359-:1359," \
  -e DISPLAY=:99 \
  -e WIDTH=1280 \
  -e HEIGHT=720 \
  -e NOPICKER=true \
  sickcodes/docker-osx:naked