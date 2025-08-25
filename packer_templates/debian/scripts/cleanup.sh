#!/bin/bash

set -e

function try_to_remove() {
    pkg=$1
    if dpkg --list | grep --quiet "${pkg}"
    then
        sudo apt-get purge -y "${pkg}"
    fi
    return 0
}

sudo apt-mark manual python3

# Kernel stuff.
dpkg --list | awk '{ print $2 }' | grep 'linux-headers' | xargs sudo apt-get -y purge;
dpkg --list | awk '{ print $2 }' | grep 'linux-image-[1-9].*' | grep -v `uname -r` | xargs sudo apt-get -y purge;

sudo apt-get purge -y nftables
sudo apt-get purge -y mc unzip
sudo apt-get purge -y ispell ibritish iamerican
sudo apt-get purge -y network-manager
sudo apt-get -y purge gcc build-essential git
dpkg --list | awk '{ print $2 }' | grep -- '-dev\(:[a-z0-9]\+\)\?$' | xargs sudo apt-get -y purge;

try_to_remove installation-report
try_to_remove kmouth
try_to_remove bluedevil
try_to_remove kamera
try_to_remove smartmontools
try_to_remove firmware-linux-free
try_to_remove laptop-detect
try_to_remove libjansson4
try_to_remove xserver-xorg-video-vmware
try_to_remove plasma-firewall
try_to_remove plasma-desktop-doc
try_to_remove plasma-discover
try_to_remove wayland-utils
try_to_remove xdg-desktop-portal-gtk
try_to_remove vulkan-tools
try_to_remove kdeconnect
try_to_remove webext-plasma-browser-integration
try_to_remove kwrite
try_to_remove khelpcenter
try_to_remove firefox-esr
try_to_remove konqueror
try_to_remove kate
sudo apt-get -y autoremove
sudo apt-get -y clean
