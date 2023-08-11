FROM debian:11.4

RUN apt update
RUN apt install qemu uml-utilities virt-manager git \
    wget libguestfs-tools p7zip-full make dmg2img nano vim socat -y

ENV pass=${VNC_PASSWORD}

EXPOSE 5900
EXPOSE 1234
EXPOSE 1359

WORKDIR /opt/OSX-KVM

ENTRYPOINT ["/opt/OSX-KVM/OpenCore-Boot-headless.sh"]