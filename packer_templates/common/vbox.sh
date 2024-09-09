#!/bin/bash

set -e

if [ "${PACKER_BUILDER_TYPE}" != "virtualbox-iso" ]
then
    exit 0
fi

ver=`cat "/home/vagrant/.vbox_version"`
iso_path="/home/vagrant/VBoxGuestAdditions_${ver}.iso"

sudo mkdir -p /tmp/vbox
sudo mount -o loop "${iso_path}" /tmp/vbox
ls -l /tmp/vbox

if [ -f "/bin/dnf" ]
then
    true
elif [ -f "/usr/bin/apt-get" ]
then
    sudo apt-get install -y build-essential dkms bzip2 tar linux-headers-"$(uname -r)"
fi

sudo /tmp/vbox/VBoxLinuxAdditions.run --nox11 || true

# Clenaup.
if [ -f "/bin/dnf" ]
then
    true
elif [ -f "/usr/bin/apt-get" ]
then
    sudo apt-get remove -y build-essential gcc g++ make libc6-dev dkms linux-headers-"$(uname -r)"
fi
sudo umount /tmp/vbox
sudo rm -rf /tmp/vbox
sudo rm -f "${iso_path}"
sudo rm -rf /var/log/vboxadd*
