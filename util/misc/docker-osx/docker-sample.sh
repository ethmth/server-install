# run an existing image in current directory, with a screen, with SSH, with nopicker.

stat mac_hdd_ng.img # make sure you have an image if you're using :naked

docker run -it \
    -v "${PWD}/mac_hdd_ng.img:/image" \
    --device /dev/kvm \
    -e "DISPLAY=${DISPLAY:-:0.0}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -p 50922:10022 \
    -e NOPICKER=false \
    -e GENERATE_SPECIFIC=true \
    -e DEVICE_MODEL="iMacPro1,1" \
    -e SERIAL="C02TW0WAHX87" \
    -e BOARD_SERIAL="C027251024NJG36UE" \
    -e UUID="5CCB366D-9118-4C61-A00A-E5BAF3BED451" \
    -e MAC_ADDRESS="A8:5C:2C:9A:46:2F" \
    -e WIDTH=1000 \
    -e HEIGHT=1000 \
    sickcodes/docker-osx:naked