#!/bin/bash

git clone --depth 1 https://github.com/cfinke/OSX-Messages-Exporter.git
cp ./OSX-Messages-Exporter/messages-exporter.php ${HOME}/bin/messages-exporter.php

echo "php $HOME/bin/messages-exporter.php -o ~/Desktop/Messages/" ${HOME}/bin/message-backup
chmod +rx ${HOME}/bin/message-backup

echo "Run 'message-backup' to backup iMessages to Desktop"