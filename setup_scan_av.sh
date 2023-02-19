#!/bin/bash
# Copyright (c) 2023 CaoS
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


# Setup AV Scan: Cron Job & Log files

# Add AV Scan script to CRON


source .settings.sh

# Regular hourly scan of home dir
CMD_CRON="${DIR_SCRIPTS}scan_av.sh"
TXT_CRON="0 * * * * ${CMD_CRON}"

( crontab -l | grep -v -F "${CMD_CRON}" ; echo "${TXT_CRON}") | crontab -
# Root scan should run 1230p & 1230a
TXT_CRON="30 12,00 * * * ${CMD_CRON}"

( sudo crontab -l | grep -v -F "${CMD_CRON}" ; echo "${TXT_CRON} 1") | sudo crontab -

# Add to log rotation

read -r -d '' TXT_LOG << END
${DIR_LOGS}*.log {
    daily
    dateext
    dateformat -%d%m%Y
    missingok
    rotate 90
    compress
    delaycompress
    notifempty
    create 600 root root
}
END

echo "${TXT_LOG}" > clamav
sudo mv clamav /etc/logrotate.d/clamav