#!/bin/bash
# Copyright (c) 2023 CaoS
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


# Setup nVidia reset: Cron Job & Log files
# nVidia powerd tends to exceed acceptable error limits. This schedules periodic reset.

# Include settings & cron functions
source .settings.sh
source ./cron.sh

# Setup hourly nVidia reset 
CMD_CRON="cd ${DIR_SCRIPTS} && ./reset_nvidia.sh"
TXT_CRON="0 * * * * ${CMD_CRON}"

writeCron "${CMD_CRON}" "${TXT_CRON}" "1"

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

echo "${TXT_LOG}" > nvidia_reset
sudo mv nvidia_reset /etc/logrotate.d/nvidia_reset
