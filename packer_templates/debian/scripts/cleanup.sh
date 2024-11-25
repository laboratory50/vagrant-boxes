#!/bin/bash

set -e

# Clean a kernel stuff.
dpkg --list | awk '{ print $2 }' | grep 'linux-headers' | xargs sudo apt-get -y purge;
dpkg --list | awk '{ print $2 }' | grep 'linux-image-[1-9].*' | grep -v `uname -r` | xargs sudo apt-get -y purge;

# Remove packages.
# sudo apt-get -y purge installation-report
dpkg --list | awk '{ print $2 }' | grep 'kmouth\|bluedevil\|kamera\|smartmontools' | xargs sudo apt-get -y purge;
sudo apt-get -y purge gcc build-essential git
dpkg --list | awk '{ print $2 }' | grep -- '-dev\(:[a-z0-9]\+\)\?$' | xargs sudo apt-get -y purge;

sudo apt-get purge -y nftables
sudo apt-get purge -y libsqlite3-0
sudo apt-get purge -y mc unzip
sudo apt-get purge -y ispell ibritish iamerican
sudo apt-get purge -y xauth libx11-data libx11-6
sudo apt-get purge -y firmware-linux-free laptop-detect
sudo apt-get purge -y libjansson4
sudo apt-get -y autoremove

# Clean an apt cache.
sudo apt-get -y clean
