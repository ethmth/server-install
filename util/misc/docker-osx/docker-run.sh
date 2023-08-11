#!/bin/bash

docker run \
    -e RAM=4 \
    -e SMP=4 \
    -e CORES=2 \
    -e MAC_ADDRESS="00:25:4B:59:36:0D" \
    -e SCREEN_SHARE_PORT=5900 \
    --device /dev/kvm \
    --device /dev/snd \
    sickcodes/docker-osx:high-sierra