#!/bin/bash

git clone --depth 1 https://github.com/acidanthera/OpenCorePkg.git
cd ./OpenCorePkg/Utilities/macserial/
make
chmod +x ./macserial

sudo cp ./macserial /usr/bin/macserial
sudo chmod +rx /usr/bin/macserial