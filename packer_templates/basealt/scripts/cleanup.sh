#!/bin/bash
# Зачистка лишних пакетов для Росы.

set -e

sudo rm -rf /root/.install-log

# sudo apt-mark manual sudo
sudo apt-get -y remove LibreOffice-still LibreOffice-still-common java-11-openjdk
sudo apt-get -y remove ghostscript ghostscript-common cups hplip hplip-common printer-testpages
sudo apt-get -y remove virtualbox-common docs-simply-linux vlc eiskaltdcpp-gtk homebank stardict transmission-gtk xfburn gnome-software ImageMagick lvm2
# sudo apt-get -y remove vulkan-filesystem vulkan-amdgpu
# sudo apt-get -y remove gnome-bluetooth blueberry bluez-tools
sudo remove-old-kernels -y
sudo apt-get remove -y update-kernel
sudo apt-get -y autoremove

# Clean an apt cache.
sudo apt-get -y clean
