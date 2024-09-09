#!/bin/bash
# Минимальный тюнинг рабочего стола.
# Если X System нет, то сразу выходим с кодом 0.

set -e

if [ ! -f /usr/bin/Xorg ]
then
    exit 0
fi

# Alt.
if [ -f /etc/altlinux-release ]
then
    sudo apt-get -y install xorg-drv-qxl
# Debian и ко.
elif [ -f /etc/debian_version ] || [ -f /etc/astra_version ]
then
    sudo apt-get -y install xserver-xorg-video-qxl
# Fedora.
elif [ -f /etc/fedora-release ]
then
    sudo dnf -y install xorg-x11-drv-qxl kdm
    sudo systemctl disable sddm
    sudo systemctl enable kdm
# РЕД ОС.
elif [ -f /etc/redos-release ]
then
    sudo dnf -y install xorg-x11-drv-qxl
# Роса.
elif [ -f /etc/rosa-release ]
then
    sudo dnf -y install x11-driver-video-qxl
fi

sudo tee /etc/X11/xorg.conf << EndOfMessage
Section "Device"
    Identifier "Card0"
    Driver "qxl"
EndSection

Section "Screen"
    Identifier "Screen0"
    Device "Card0"
    Monitor "Monitor0"
    SubSection "Display"
        Modes "1920x1080"
    EndSubSection
EndSection
EndOfMessage

if [ -f /etc/altlinux-release ]
then
    sudo systemctl restart display-manager
fi
