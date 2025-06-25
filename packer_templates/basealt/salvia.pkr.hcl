variables {
    iso_url = "http://ftp.altlinux.org/pub/distributions/ALTLinux/p11/images/server/x86_64/alt-server-11.0-x86_64.iso"
    iso_checksum = "md5:35af6c21fd3f73005647f676664de76a"
    boot_command = [
        "e<wait><down><down><down><down><end> ai curl=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<f10>",
        "<wait25m>",
        # Авто-установка завершена. Сейчас будем разбираться с sudo и sshd. А можно ли по-человечески?
        "root<enter><wait>password<enter><wait>",
        "echo -e 'Defaults:vagrant !requiretty\\n%vagrant ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/vagrant<enter><wait>",
        "chmod 440 /etc/sudoers.d/vagrant<enter><wait>",
        "gpasswd -a vagrant wheel<enter><wait>",
        "echo 'SUBSYSTEM==\"net\", ACTION==\"add\", DRIVERS==\"?*\", ATTR{type}==\"1\", NAME=\"eth0\"' > /etc/udev/rules.d/70-persistent-net.rules<enter><wait>",
        "echo -e 'BOOTPROTO=dhcp\\nTYPE=eth\\nCONFIG_WIRELESS=no' > /etc/net/ifaces/eth0/options<enter><wait>",
        "rm -rf /etc/net/ifaces/enp0s3<enter><wait>",
        "rm -rf /etc/net/ifaces/ens3<enter><wait>",
        "sed -i '/PasswordAuthentication yes/s/# //g' /etc/openssh/sshd_config<enter><wait>",
        "systemctl enable sshd && systemctl start sshd<enter>"
    ]
}

source "qemu" "salvia" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/autoinstall.scm" = templatefile("${path.root}/salvia-http/autoinstall.pkrtpl", {boot="/dev/vda"}),
        "/pkg-groups.tar" = file("${path.root}/salvia-http/pkg-groups.tar"),
        "/vm-profile.scm" = file("${path.root}/salvia-http/vm-profile.scm")
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "1m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S shutdown -P now"
}

source "virtualbox-iso" "salvia" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = 30000
    memory = 5120
    gfx_controller = "vmsvga"
    gfx_vram_size = 33
    guest_os_type = "Debian_64"
    guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
    guest_additions_mode = "upload"
    guest_additions_interface = "sata"
    hard_drive_interface = "sata"
    iso_interface = "sata"
    vboxmanage = [["modifyvm", "{{.Name}}", "--audio", "none", "--nat-localhostreachable1", "on"]]
    virtualbox_version_file = ".vbox_version"
    http_content = {
        "/autoinstall.scm" = templatefile("${path.root}/salvia-http/autoinstall.pkrtpl", {boot="/dev/sda"}),
        "/pkg-groups.tar" = file("${path.root}/salvia-http/pkg-groups.tar"),
        "/vm-profile.scm" = file("${path.root}/salvia-http/vm-profile.scm")
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "1m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "echo 'password' | sudo -S /sbin/shutdown -hP now"
}

source "qemu" "salvia-kde" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/autoinstall.scm" = templatefile("${path.root}/salvia-http/autoinstall.pkrtpl", {boot="/dev/vda"}),
        "/pkg-groups.tar" = file("${path.root}/salvia-http/pkg-groups.tar"),
        "/vm-profile.scm" = file("${path.root}/salvia-http/vm-profile.scm")
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "1m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S shutdown -P now"
}

build {
    sources = ["source.qemu.salvia", "source.virtualbox-iso.salvia", "source.qemu.salvia-kde"]
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/scripts/upgrade.sh",
            "${path.root}/../common/reboot.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/scripts/install-kde.sh",
            "${path.root}/../common/qemu.sh",
            "${path.root}/../common/x.sh",
            "${path.root}/../common/vagrant.sh",
            "${path.root}/../common/love.sh",
            "${path.root}/../common/machine-id-and-random-seed.sh",
            "${path.root}/../common/logs-and-cache.sh",
            "${path.root}/../common/minimize.sh"
        ]
    }
    post-processor "vagrant" {
        output = "${source.type}/${source.name}.box"
        vagrantfile_template = "files/Vagrantfile-${source.name}"
    }
}

