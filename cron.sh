#!/bin/bash

writeCron() {
    CMD_CRON=${1}
    TXT_CRON=${2}
    IS_ADMIN=${3}
    CURRENT_USER="ROOT"
    if [ ${IS_ADMIN} -eq "0" ]
    then
        CURRENT_USER=${USER}
        ( crontab -l | grep -v -F "${CMD_CRON}" ; echo "${TXT_CRON}") | crontab -   
    else 
        ( sudo crontab -l | grep -v -F "${CMD_CRON}" ; echo "${TXT_CRON}") | sudo crontab -   
    fi
        echo "Added Cron for ${CURRENT_USER}"
}