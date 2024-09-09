#!/bin/bash

set -e

sudo rm -rf /tmp/* /var/tmp/*
sudo find /var/cache -type f -exec rm -rf {} \;
sudo find /var/log -type f -name '*.xz' -exec rm -f {} \;
sudo find /var/log -type f -name '*.gz' -exec rm -f {} \;
sudo find /var/log -type f -name '*.log.old' -exec rm -f {} \;
sudo find /var/log -type f -exec truncate --size=0 {} \;

if [ -f /home/vagrant/.bash_history ]
then
    rm -f /home/vagrant/.bash_history
fi
