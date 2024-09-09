#!/bin/bash

set -e

# Generate the russian locale.
echo 'ru_RU.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen
sudo locale-gen
echo 'LANG=ru_RU.UTF-8' | sudo tee /etc/default/locale

# Set font.
sudo sed -i '/CODESET/c\CODESET="FullCyrSlav"' /etc/default/console-setup
