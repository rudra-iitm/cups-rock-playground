#!/bin/sh
set -eux

# Ensure the lpadmin group exists
if ! getent group lpadmin > /dev/null; then
    groupadd -r lpadmin
fi

# Set default value for CUPSADMIN if not provided
CUPSADMIN="${CUPSADMIN:-admin}"

# Set default value for CUPSPASSWORD if not provided
CUPSPASSWORD="${CUPSPASSWORD:-$CUPSADMIN}"

# Check if the user already exists
if ! id -u "$CUPSADMIN" > /dev/null 2>&1; then
    # Create the user and add to lpadmin group
    useradd -r -G lpadmin -M "$CUPSADMIN"
else
    # Ensure the user is a member of lpadmin group
    usermod -aG lpadmin "$CUPSADMIN"
fi

# Set the user's password
echo "$CUPSADMIN:$CUPSPASSWORD" | chpasswd

echo "Starting CUPS"

exec /usr/sbin/cupsd -f
