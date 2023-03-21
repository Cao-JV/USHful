#!/bin/bash

# Copyright 2023 cao
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


# Proprietary nVidia daemon is too chatty. It hits system limits fairly quickly
# Include Settings File
source ./.settings.sh

ALERT_TITLE="nVidia reset Complete"
ALERT_BODY="Reset the nVida powerd!"
URGENCY="normal"


# Stop & restart the nVidia power Daemon
systemctl stop nvidia-powerd.service
systemctl start nvidia-powerd.service
systemctl status nvidia-powerd.service

source ./alert.sh

doSendAlert "${ALERT_TITLE}" "${ALERT_BODY}" "${URGENCY}"