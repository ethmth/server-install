#!/bin/bash

git clone --depth 1 https://github.com/acidanthera/OpenCorePkg.git
cd ./OpenCorePkg/Utilities/macserial/
make
chmod +x ./macserial

cp ./macserial ${HOME}/bin/macserial
chmod +rx ${HOME}/bin/macserial

echo "Run 'macserial' to verify values specified in values.conf"