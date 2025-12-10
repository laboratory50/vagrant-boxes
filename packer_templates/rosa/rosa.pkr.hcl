variables {
    rosa2021_1_iso_url = "https://mirror.rosa.ru/rosa/rosa2021.1/iso/ROSA.FRESH.12/server/ROSA.FRESH.SERVER.12.5.1.x86_64.iso"
    rosa2021_1_iso_checksum = "md5:16f661fe971543ad9f2ee5ab98895c76"
    rosa2021_1_boot_command = [
        "<wait><esc><wait>e",
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/2021.1.cfg<F10>"
    ]
    fresh_kde_iso_url = "https://mirror.yandex.ru/rosa/rosa2021.1/iso/ROSA.FRESH.12/plasma5/ROSA.FRESH.PLASMA5.12.5.1.x86_64.iso"
    fresh_kde_iso_checksum = "md5:7c901d9f7e8300e1cf729ce3078174f7"
    rosa13_iso_url = "https://mirror.rosa.ru/rosa/rosa13/iso/ROSA.FRESH.13/server/ROSA.FRESH.SERVER.13.1.x86_64.iso"
    rosa13_iso_checksum = "md5:e824d77f32cff2c154e4f45bd8672678"
    rosa13_boot_command = [
        "<wait2s><enter><wait3s>e<wait>",
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rosa13.cfg<F10>"
    ]
    shutdown_command = "sudo shutdown -P now"
}

source "qemu" "rosa2021_1" {
    iso_url = var.rosa2021_1_iso_url
    iso_checksum = var.rosa2021_1_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = var.rosa2021_1_boot_command
    shutdown_command = var.shutdown_command
}

source "virtualbox-iso" "rosa2021_1" {
    iso_url = var.rosa2021_1_iso_url
    iso_checksum = var.rosa2021_1_iso_checksum
    disk_size = 30000
    memory = 5120
    gfx_controller = "vmsvga"
    gfx_vram_size = 33
    guest_os_type = "Fedora_64"
    guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
    guest_additions_mode = "upload"
    guest_additions_interface = "sata"
    hard_drive_interface = "sata"
    iso_interface = "sata"
    vboxmanage = [["modifyvm", "{{.Name}}", "--audio", "none", "--nat-localhostreachable1", "on"]]
    virtualbox_version_file = ".vbox_version"
    http_directory = "http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    boot_wait = "6s"
    boot_command = var.rosa2021_1_boot_command
    shutdown_command = var.shutdown_command
}

source "qemu" "fresh-kde" {
    iso_url = var.fresh_kde_iso_url
    iso_checksum = var.fresh_kde_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = [
        "<esc><wait>e",
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/2021.1.cfg<F10>"
    ]
    shutdown_command = var.shutdown_command
}

source "qemu" "rosa13" {
    iso_url = var.rosa13_iso_url
    iso_checksum = var.rosa13_iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_directory = "http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "3s"
    boot_command = var.rosa13_boot_command
    shutdown_command = var.shutdown_command
}

source "virtualbox-iso" "rosa13" {
    iso_url = var.rosa13_iso_url
    iso_checksum = var.rosa13_iso_checksum
    disk_size = 30000
    memory = 5120
    gfx_controller = "vmsvga"
    gfx_vram_size = 33
    guest_os_type = "Fedora_64"
    guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
    guest_additions_mode = "upload"
    guest_additions_interface = "sata"
    hard_drive_interface = "sata"
    iso_interface = "sata"
    vboxmanage = [["modifyvm", "{{.Name}}", "--audio", "none", "--nat-localhostreachable1", "on"]]
    virtualbox_version_file = ".vbox_version"
    http_directory = "http"
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    boot_wait = "6s"
    boot_command = var.rosa13_boot_command
    shutdown_command = var.shutdown_command
}

build {
    sources = [
        "source.qemu.rosa2021_1",
        "source.virtualbox-iso.rosa2021_1",
        "source.qemu.fresh-kde",
        "source.qemu.rosa13",
        "source.virtualbox-iso.rosa13"
    ]
    provisioner "shell" {
        expect_disconnect = true
        scripts = [
            "${path.root}/scripts/upgrade.sh",
            "${path.root}/../common/reboot.sh",
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/../common/x.sh",
            "${path.root}/../common/vagrant.sh",
            "${path.root}/../common/love.sh",
            "${path.root}/../common/qemu.sh",
            "${path.root}/../common/vbox.sh",
            "${path.root}/../common/machine-id-and-random-seed.sh",
            "${path.root}/../common/logs-and-cache.sh",
            "${path.root}/../common/minimize.sh"
        ]
    }
    post-processor "vagrant" {
        output = "${source.type}/${source.name}.box"
        vagrantfile_template = "files/Vagrantfile"
    }
}
