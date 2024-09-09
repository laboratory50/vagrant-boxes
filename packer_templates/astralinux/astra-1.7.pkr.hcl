variables {
    smolensk_1_7_iso_url = "smolensk-1.7.0-11.06.2021_12.40.iso"
    smolensk_1_7_iso_checksum = "md5:659a34caf83ae0bfe9e123e3bb831278"
    smolensk_1_7_repos = "deb https://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.5/repository-base 1.7_x86-64 main contrib non-free"
    # TODO: Можно как-то обойтись без переключения на вирт. консоль и ручных манипуляций с сетью?
    boot_command = [
        "<esc><wait><esc><wait><enter>",
        "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "astra-license/license=true ",
        "debian-installer/language=en debian-installer/locale=en_US.UTF-8 keyboard-configuration/xkb-keymap=us ",
        "priority=critical ",
        "grub-installer/bootdev=/dev/vda",
        "<enter><wait70s>",
        # Не удалось скачать файл! Переключаемся на вирт. консоль и оживляем сетевой интерфейс.
        "<rightCtrlOn><rightAltOn><f2><rightAltOff><rightCtrlOff><enter><wait>",
        "dhclient ens3<enter><wait>",
        "<rightCtrlOn><rightAltOn><f1><rightAltOff><rightCtrlOff>",
        "<enter><wait><enter><wait><enter>"
    ]
}

source "qemu" "smolensk" {
    iso_url = var.smolensk_1_7_iso_url
    iso_checksum = var.smolensk_1_7_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.7.pkrtpl", {tasks = "Base, SSH server", level="Base security level Smolensk"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "1s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "qemu" "smolensk-fly" {
    iso_url = var.smolensk_1_7_iso_url
    iso_checksum = var.smolensk_1_7_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.7.pkrtpl", {tasks = "Base, SSH server, Fly desktop", level="Base security level Smolensk"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "50m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "1s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "qemu" "orel" {
    iso_url = var.smolensk_1_7_iso_url
    iso_checksum = var.smolensk_1_7_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.7.pkrtpl", {tasks = "Base, SSH server", level="Base security level Orel"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "30m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "1s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.smolensk", "source.qemu.smolensk-fly", "source.qemu.orel"]
    provisioner "shell" {
        inline = [
            "echo '${var.smolensk_1_7_repos}' | sudo tee /etc/apt/sources.list",
            "sudo apt-get update && sudo apt-get -y -o Dpkg::Options::='--force-confnew' full-upgrade"
        ]
    }
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/../common/reboot.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/../debian/scripts/ru-locale.sh",
            "${path.root}/../debian/scripts/lab50-key.sh",
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
        output = "${source.type}/${source.name}-1.7.box"
        vagrantfile_template = "files/Vagrantfile"
    }
}
