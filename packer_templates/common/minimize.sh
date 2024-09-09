#!/bin/bash

set -e

# Whiteout root.
count=$(df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}')
count=$(($count-1))
sudo dd if=/dev/zero of=/root/whitespace bs=1M count=$count || echo "dd exit code $? is suppressed";
sudo rm /root/whitespace

sync;
