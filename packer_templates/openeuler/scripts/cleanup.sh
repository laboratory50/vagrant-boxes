#!/bin/bash

sudo dnf remove -y cockpit
sudo dnf remove -y wayland xorg-x11-utils libX11 fontconfig cairo gdk-pixbuf2 pango libxkbcommon xkeyboard-config
sudo dnf remove -y gcc boost-chrono boost-atomic boost-timer boost-filesystem boost-system
sudo dnf remove -y perl perl-devel perl-Filter-Simple perl-Digest perl-Encode perl-Env perl-URI perl-threads
sudo dnf remove -y samba-common samba-client-libs sssd sssd-common sssd-ad sssd-client sssd-krb5 sssd-ldap
sudo dnf remove -y rsyslog yum security-tool
sudo dnf remove -y selinux-policy selinux-policy-targeted
sudo dnf remove -y dnf-plugins-core
sudo dnf remove -y python3-six python3-dateutil
sudo dnf remove -y openssl openssl-pkcs11 pcsc-lite
sudo dnf remove -y chrony duktape polkit
