variables {
    smolensk_1_6_iso_url = "smolensk-1.6-20.06.2018_15.56.iso"
    smolensk_1_6_iso_checksum = "md5:73ca5894baa7c038f67ad395e76943d9"
    smolensk_1_6_repos = <<-EOF
    # Основной репозиторий + обновления.
    deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository smolensk main contrib non-free
    deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-update smolensk main contrib non-free
    # Диск со средствами разработки + обновления.
    deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev smolensk main contrib non-free
    deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev-update smolensk main contrib non-free
    EOF
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
        "anna-install isc-dhcp-client-udeb<enter><wait3s>",
        "dhclient ens3<enter><wait>",
        "<rightCtrlOn><rightAltOn><f1><rightAltOff><rightCtrlOff>",
        "<enter><wait><enter><wait><enter>"
    ]
}

source "qemu" "smolensk" {
    iso_url = var.smolensk_1_6_iso_url
    iso_checksum = var.smolensk_1_6_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.6.pkrtpl", {tasks = "Base, SSH server"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "40m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "1s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "qemu" "smolensk-fly" {
    iso_url = var.smolensk_1_6_iso_url
    iso_checksum = var.smolensk_1_6_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.6.pkrtpl", {tasks = "Base, SSH server, Fly desktop"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "40m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "1s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.smolensk", "source.qemu.smolensk-fly"]
    provisioner "shell" {
        inline = [
            "echo '${var.smolensk_1_6_repos}' | sudo tee /etc/apt/sources.list",
            "sudo apt-get update && sudo UCF_FORCE_CONFFOLD=YES apt-get -y -o Dpkg::Options::='--force-confnew' full-upgrade"
        ]
    }
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/../common/reboot.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/../debian/scripts/ru-locale.sh",
            "${path.root}/../debian/scripts/lab50-key.sh",
            "${path.root}/../common/vagrant.sh",
            "${path.root}/../common/love.sh",
            "${path.root}/../common/machine-id-and-random-seed.sh",
            "${path.root}/../common/logs-and-cache.sh",
            "${path.root}/../common/minimize.sh"
        ]
    }
    post-processor "vagrant" {
        output = "${source.type}/${replace(source.name, "smolensk", "smolensk-1.6")}.box"
        vagrantfile_template = "files/Vagrantfile"
    }
}
