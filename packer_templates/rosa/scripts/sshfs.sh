#!/bin/bash
# Разрабы переименовали fuse-sshfs в sshfs-fuse, из-за чего отваливается Vagrant-плагин sshfs.
# Этот скрипт ставит fuse-sshfs из Федоры на Росу Fresh.

set -e

PACKAGE_URL='http://mirror.linux-ia64.org/fedora/linux/releases/34/Everything/x86_64/os/Packages/f/fuse-sshfs-3.7.1-2.fc34.x86_64.rpm'

if grep --quiet 'ROSA Fresh Desktop' /etc/os-release
then
    curl ${PACKAGE_URL} --output /tmp/fuse-sshfs.rpm
    sudo dnf -y install /tmp/fuse-sshfs.rpm
fi
