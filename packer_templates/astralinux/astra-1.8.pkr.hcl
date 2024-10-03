variables {
    smolensk_1_8_iso_url = "installation-1.8.1.6-27.06.2024_14.12-di.iso"
    smolensk_1_8_iso_checksum = "md5:56eadb3e65df37d5443200eb6638e728"
    smolensk_1_8_repos = <<-EOF
    deb https://dl.astralinux.ru/astra/frozen/1.8_x86-64/1.8.1/repository-main 1.8_x86-64 main contrib non-free
    deb https://dl.astralinux.ru/astra/frozen/1.8_x86-64/1.8.1/repository-extended 1.8_x86-64 main contrib non-free
    EOF
    boot_command = [
        "<wait><down><enter><wait><esc><wait><enter><wait>",
        "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "astra-license/license=true ",
        "priority=critical ",
        "debian-installer/language=en debian-installer/locale=en_US.UTF-8 keyboard-configuration/xkb-keymap=us ",
        "netcfg/get_hostname=astra netcfg/get_domain=vagrantup.com ",
        "debconf/frontend=noninteractive ",
        "<enter>"
    ]
}

source "qemu" "smolensk" {
    iso_url = var.smolensk_1_8_iso_url
    iso_checksum = var.smolensk_1_8_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.8.pkrtpl", {tasks = "Base, SSH server", level="Base security level Smolensk"})
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

source "qemu" "smolensk-fly" {
    iso_url = var.smolensk_1_8_iso_url
    iso_checksum = var.smolensk_1_8_iso_checksum
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/astra-1.8.pkrtpl", {tasks = "Base, SSH server, Fly desktop", level="Base security level Smolensk"})
    }
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "70m"
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
            "echo '${var.smolensk_1_8_repos}' | sudo tee /etc/apt/sources.list",
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
        output = "${source.type}/${source.name}-1.8.box"
        vagrantfile_template = "files/Vagrantfile"
    }
}
