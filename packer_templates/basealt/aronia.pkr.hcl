# https://www.altlinux.org/Starterkits
# https://www.altlinux.org/Альт_Сервер_10
# https://www.altlinux.org/Альт_Рабочая_станция_10
# https://www.altlinux.org/Simply_Linux_10

variables {
    starterkit_iso_url = "https://mirror.yandex.ru/altlinux-starterkits/x86_64/permalink/alt-p10-server-systemd-latest-x86_64.iso"
    starterkit_iso_checksum = "md5:eee0658504973c781e5c5538d8e9ffd8"
    server_iso_url = "http://ftp.altlinux.org/pub/distributions/ALTLinux/p10/images/server/x86_64/alt-server-10.1-x86_64.iso"
    server_iso_checksum = "md5:80d02a4d1cf54a8ab5868615cabb4255"
    workstation_iso_url = "http://ftp.altlinux.org/pub/distributions/ALTLinux/p10/images/workstation/x86_64/alt-workstation-10.1-x86_64.iso"
    workstation_iso_checksum = "md5:84605e6eb98ae4015da7a7d719235941"
    simply_iso_url = "http://ftp.altlinux.org/pub/distributions/ALTLinux/p10/images/simply/x86_64/slinux-10.1-x86_64.iso"
    simply_iso_checksum = "md5:e41b4be3d686e30029e474001e74a6ca"
    boot_command = [
        "e<wait>",
        "<down><down><down><end> ai curl=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<f10>",
        "<wait30m>",
        # Авто-установка завершена. Сейчас будем разбираться с sudo и ssh. А можно ли по-человечески?
        "<leftCtrlOn><leftAltOn><f3><leftAltOff><leftCtrlOff><wait2s>",
        "vagrant<enter><wait>password<enter><wait>",
        "su root<enter><wait>password<enter><wait>",
        "apt-get update<enter><wait30s>",
        "apt-get install -y vim-console mc curl sudo openssh<enter><wait1m>",
        "sed -i '/PasswordAuthentication yes/s/# //g' /etc/openssh/sshd_config<enter><wait>",
        "echo -e 'Defaults:vagrant !requiretty\\n%vagrant ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/vagrant<enter><wait>",
        "chmod 440 /etc/sudoers.d/vagrant<enter><wait>",
        "systemctl enable sshd && systemctl start sshd<enter>"
    ]
}

source "qemu" "starterkit" {
    iso_url = var.starterkit_iso_url
    iso_checksum = var.starterkit_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "starterkit-http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "1m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = [
        "<tab><wait> ai curl=http://{{ .HTTPIP }}:{{ .HTTPPort }}/<enter>",
        "<wait10m>",
        # Авто-установка завершена. Сейчас будем разбираться с sudo и ssh. А можно ли по-человечески?
        "<leftCtrlOn><leftAltOn><f3><leftAltOff><leftCtrlOff><wait2s>",
        "vagrant<enter><wait2s>password<enter><wait2s>",
        "su root<enter><wait>password<enter><wait>",
        "apt-get update<enter><wait30s>",
        "apt-get install -y vim-console mc curl sudo openssh<enter><wait1m>",
        "sed -i '/PasswordAuthentication yes/s/# //g' /etc/openssh/sshd_config<enter><wait>",
        "echo -e 'Defaults:vagrant !requiretty\\n%vagrant ALL=(ALL) NOPASSWD: ALL\n' > /etc/sudoers.d/vagrant<enter><wait>",
        "chmod 440 /etc/sudoers.d/vagrant<enter><wait>",
        "systemctl enable sshd && systemctl start sshd<enter>"
    ]
    shutdown_command = "sudo -S shutdown -P now"
}

source "qemu" "server" {
    iso_url = var.server_iso_url
    iso_checksum = var.server_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "server-http"
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

source "qemu" "workstation" {
    iso_url = var.workstation_iso_url
    iso_checksum = var.workstation_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "workstation-http"
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

source "qemu" "simply" {
    iso_url = var.simply_iso_url
    iso_checksum = var.simply_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "simply-http"
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
    sources = ["source.qemu.workstation", "source.qemu.simply"]
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/scripts/update.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/../common/x.sh",
            "${path.root}/../common/vagrant.sh",
            "${path.root}/../common/love.sh",
            "${path.root}/../common/machine-id-and-random-seed.sh",
            "${path.root}/../common/logs-and-cache.sh",
            "${path.root}/../common/minimize.sh"
        ]
    }
    post-processor "vagrant" {
        output = "aronia-${source.name}.box"
        vagrantfile_template = "files/Vagrantfile-desktop"
    }
}

build {
    sources = ["source.qemu.starterkit", "source.qemu.server"]
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/scripts/update.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/../common/vagrant.sh",
            "${path.root}/../common/love.sh",
            "${path.root}/../common/machine-id-and-random-seed.sh",
            "${path.root}/../common/logs-and-cache.sh",
            "${path.root}/../common/minimize.sh"
        ]
    }
    post-processor "vagrant" {
        output = "aronia-${source.name}.box"
        vagrantfile_template = "files/Vagrantfile-server"
    }
}
