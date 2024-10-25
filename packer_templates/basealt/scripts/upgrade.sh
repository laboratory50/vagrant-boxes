#!/bin/bash

set -e

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y update-kernel
sudo update-kernel -y
