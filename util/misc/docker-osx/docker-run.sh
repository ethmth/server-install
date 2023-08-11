#!/bin/bash

docker run -i \
    --device /dev/kvm \
    -p 5900:99 \
    -e RAM=4 \
    -e SMP=4 \
    -e CORES=2 \
    -e AUDIO_DRIVER=none \
    -e MAC_ADDRESS="00:11:22:33:44:55" \
    -e EXTRA="-display none -vnc 0.0.0.0:99,password=on" \
    sickcodes/docker-osx:high-sierra