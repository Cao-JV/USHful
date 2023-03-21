#!/bin/bash

# Copyright 2023 cao
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Include Settings File
source ./.settings.sh

# Declaratoins
DIR_TO_SCAN="${DIR_SCRIPTS}"
FILE_LOG="${DIR_LOGS}av/scan.log"
FILE_TMP_LOG="${DIR_LOGS}scan.tmp"
MAIL_FROM="${EMAIL_SYSTEM_FROM}"
MAIL_TO="${EMAIL_ALERT_LIST}"


ALERT_TITLE="AV Scan Complete"
ALERT_BODY="No infected files detected!"
# Arguments
IS_ADMIN_SCAN=$1

doNotify() {
    URGENCY="normal"

        

    if [ `cat ${FILE_TMP_LOG} | grep Infected | grep -v 0 | wc -l` != 0 ] 
    then
        URGENCY="critical"
        echo "`tail -n 50 ${FILE_TMP_LOG}`" >> ${ALERT_BODY}               
    fi

    source ./alert.sh

    doSendAlert "${ALERT_TITLE}" "${ALERT_BODY}" "${URGENCY}"

    if [ ${SHOULD_EMAIL_AV} -eq 1 ]
    then
        doSendEmail "${ALERT_TITLE}" "${ALERT_BODY}" "${URGENCY}" "${MAIL_FROM}" "${MAIL_TO}"
    fi

    if [ "${URGENCY}"="critical" ]
    then 
        touch ${FILE_LOG}
        cat ${FILE_TMP_LOG} >> ${FILE_LOG}
    fi
    rm -rf ${FILE_TMP_LOG}

}

doScan() {
    touch ${FILE_TMP_LOG}
    if [ ${IS_ADMIN_SCAN} -eq 1 ]
    then
        clamscan -r ${DIR_TO_SCAN}  --exclude-dir=/proc/ --exclude-dir=/sys/ --quiet --infected --log=${FILE_TMP_LOG}
    else
        clamscan -r ${DIR_TO_SCAN} --quiet --infected --log=${FILE_TMP_LOG}
    fi
}





if [ ${IS_ADMIN_SCAN} -eq 1 ]
then
    freshclam
    DIR_TO_SCAN=`/`
fi

doScan
doNotify


