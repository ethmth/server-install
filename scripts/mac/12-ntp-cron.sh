#!/bin/bash

echo "0 * * * * /usr/bin/sntp -s in.pool.ntp.org >> /var/log/my_cron_logs.log 2>&1" | sudo crontab -
