#!/bin/bash
# Зачистка лишних пакетов для РЕД ОС.

set -e

sudo dnf remove -y pcsc-lite
sudo dnf remove -y openssl openssl-pkcs11
sudo dnf remove -y sssd sssd-client sssd-common
sudo dnf remove -y chrony
sudo dnf remove -y firewalld
sudo dnf remove -y selinux-policy selinux-policy-targeted
sudo dnf remove -y diffutils
sudo dnf remove -y linux-firmware
# Только на мини-версии без иксов.
if [ ! -f /usr/bin/Xorg ]
then
    # sudo dnf remove -y nss nss-sysinit nss-util
    sudo dnf remove -y jansson
    # sudo dnf remove -y libusb1 usbutils
fi

# Удаляем старые ядра.
current_kernel=`uname -r`
echo "Current kernel: ${current_kernel}."
rpm -qa kernel-* | while read package
do
    if echo "${package}" | grep -q "${current_kernel}"
    then
        echo "Skipping ${package}."
    else
        echo "Removing ${package}..."
        sudo dnf remove -y "${package}"
    fi
done

# Полируем посредством dnf autoremove.
sudo dnf autoremove -y
