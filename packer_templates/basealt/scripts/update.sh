#!/bin/bash

set -e

sudo apt-get update
sudo apt-get -y dist-upgrade
# sudo update-kernel -t std-def

sudo shutdown -r now
