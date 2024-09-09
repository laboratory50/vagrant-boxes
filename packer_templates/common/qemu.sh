#!/bin/bash

set -e

if [ "${PACKER_BUILDER_TYPE}" != "qemu" ]
then
    exit 0
fi

if [ -f /usr/bin/dnf ]
then
    sudo dnf install -y qemu-guest-agent
elif [ -f /usr/bin/apt-get ]
then
    if apt-cache show qemu-guest-agent &> /dev/null
    then
        sudo apt-get install -y qemu-guest-agent
    fi
fi
