#!/bin/bash

git clone https://github.com/acidanthera/OpenCorePkg.git
cd ./OpenCorePkg
git checkout dce5a8ff8911970aedfc61eee2ebc2597c81214b
cd Utilities/macserial/
make
chmod +x ./macserial

cp ./macserial ${HOME}/bin/macserial
chmod +rx ${HOME}/bin/macserial

echo "Run 'macserial' to verify values specified in values.conf"