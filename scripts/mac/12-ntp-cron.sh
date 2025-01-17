#!/bin/bash

echo "0 * * * * /usr/bin/sntp -s in.pool.ntp.org" | sudo crontab -
