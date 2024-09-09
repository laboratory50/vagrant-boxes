#!/bin/bash

set -e

echo 'deb http://packages.lab50.net/gosjava/11/ alse17 main' | sudo tee /etc/apt/sources.list.d/gosjava.list
sudo apt-get update
sudo apt-get -y install gosjava-jre

if apt show gosjava-jdk
then
    sudo apt-get -y install gosjava-jdk
fi
