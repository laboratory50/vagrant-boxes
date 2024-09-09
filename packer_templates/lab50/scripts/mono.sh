#!/bin/bash

set -e

echo 'deb http://packages.lab50.net/mono/ bookworm main' | sudo tee /etc/apt/sources.list.d/mono.list
sudo apt-get update
sudo apt-get -y install mono-runtime libentityframework6-cil libentityframework6-npgsql-cil libmathnetnumerics-cil
