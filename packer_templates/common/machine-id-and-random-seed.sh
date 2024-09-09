#!/bin/bash

set -e

sudo truncate --size=0 /etc/machine-id

if [ -f /var/lib/dbus/machine-id ]
then
    sudo truncate --size=0 /var/lib/dbus/machine-id
fi

# Force a new random seed to be generated.
if [ -f /var/lib/systemd/random-seed ]
then
    sudo rm -f /var/lib/systemd/random-seed
fi
