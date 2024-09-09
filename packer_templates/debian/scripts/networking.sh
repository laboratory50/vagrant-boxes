#!/bin/bash

set -e

# Disable Predictable Network Interface names and use eth0
sudo sed -i 's/en[[:alnum:]]*/eth0/g' /etc/network/interfaces;
sudo sed -i 's/GRUB_CMDLINE_LINUX="\(.*\)"/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0 \1"/g' /etc/default/grub;
sudo update-grub;

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" | sudo tee -a /etc/network/interfaces
