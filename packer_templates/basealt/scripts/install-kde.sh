#!/bin/bash

set -e

if echo "${PACKER_BUILD_NAME}" | grep --quiet -v 'kde'
then
    echo 'Skipping KDE stuff.'
    exit 0
fi

sudo apt-get update
sudo apt-get install -y kde5
