#!/bin/bash

if ! [ -e "./mac_hdd_ng_auto.img" ]; then
    echo "Image doesn't exist"
    exit 1
fi

docker run -it \
    --device /dev/kvm \
    -p 5999:5999 \
    -e RAM=4 \
    -e SMP=4 \
    -e CORES=2 \
    -e AUDIO_DRIVER=none \
    -v "./mac_hdd_ng_auto.img:/image" \
    -e ADDITIONAL_PORTS='hostfwd=tcp::1234-:1234,hostfwd=tcp::1359-:1359,' \
    -e MAC_ADDRESS="00:11:22:33:44:55" \
    -e EXTRA="-display none -vnc 0.0.0.0:99" \
    sickcodes/docker-osx:high-sierra
