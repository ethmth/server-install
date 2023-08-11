#!/bin/bash

docker run -i \
    --device /dev/kvm \
    -p 5999:5999 \
    -e RAM=4 \
    -e SMP=4 \
    -e CORES=2 \
    -e AUDIO_DRIVER=none \
    -e ADDITIONAL_PORTS='hostfwd=tcp::1234-:1234,hostfwd=tcp::1359-:1359,' \
    -e MAC_ADDRESS="00:11:22:33:44:55" \
    -e EXTRA="-display none -vnc 0.0.0.0:99,password=on" \
    sickcodes/docker-osx:high-sierra