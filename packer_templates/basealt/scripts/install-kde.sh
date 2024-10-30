#!/bin/bash

set -e

if echo "${PACKER_BUILD_NAME}" | grep --quiet -v 'kde'
then
    echo 'Skipping the KDE stuff.'
    exit 0
fi

sudo apt-get update
sudo apt-get install -y kde5-mini lightdm-kde-greeter lightdm
sudo apt-get install -y kernel-modules-drm-std-def kernel-modules-staging-std-def xorg-drv-video xorg-drv-spiceqxl
sudo systemctl set-default graphical.target
