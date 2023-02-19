#!/bin/bash

# Copyright 2023 cao
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Send notifications to GNOME Desktop & EMail

doSendAlert() {
    # $1 = Title
    # $2 = Message
    # $3 = (optional)Notification Level
    LEVEL=$3
    if [ ${#LEVEL} -le 0 ]
    then
        LEVEL="normal"
    fi

    notify-send  -u ${LEVEL} "${1}" "${2}"
}

doSendEmail() {
    # $1 = Title
    # $2 = Message
    # $3 = Importance
    # $4 = Sender
    # $5 = RecipientList
    MSG_BODY=`mktemp /tmp/av-message.XXX`
    echo "To: ${5}" >> ${MSG_BODY}
    echo "From: ${4}" >> ${MSG_BODY}
    echo "Subject: ${1}" >> ${MSG_BODY}
 
    if [ "$3" = "critical" ] 
    then
        echo "Importance: High" >> ${MSG_BODY}
        echo "X-Priority: 1" >> ${MSG_BODY}
        1 = "[ALERT] ${1}"
    fi

    echo "${2}" >> ${MSG_BODY}

    sendmail -t < ${MSG_BODY}
}