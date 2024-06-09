#!/bin/sh
set -eux

groupadd -r lpadmin

if [ -z "$CUPSADMIN" ]; then
    CUPSADMIN="admin"
fi

if [ -z "$CUPSPASSWORD" ]; then
    CUPSPASSWORD=$CUPSADMIN
fi

if [ $(grep -ci $CUPSADMIN /etc/shadow) -eq 0 ]; then
    useradd -r -G lpadmin -M $CUPSADMIN
fi

echo $CUPSADMIN:$CUPSPASSWORD | chpasswd

echo "${CUPSADMIN} ALL=(ALL:ALL) ALL" >> /etc/sudoers

echo "Starting CUPS"

exec /usr/sbin/cupsd -f