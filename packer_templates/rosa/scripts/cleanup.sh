#!/bin/bash
# Зачистка лишних пакетов для Росы.

set -e

sudo rm -f /root/anaconda-ks.cfg /root/original-ks.cfg

sudo yum -y remove linux-firmware
sudo yum -y autoremove
sudo yum -y clean all
sudo dnf remove -y --oldinstallonly
