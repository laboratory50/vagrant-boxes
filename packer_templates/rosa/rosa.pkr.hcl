variables {
    fresh_server_iso_url = "https://mirror.yandex.ru/rosa/rosa2021.1/iso/ROSA.FRESH.12/server/ROSA.FRESH.SERVER.12.5.1.x86_64.iso"
    fresh_server_iso_checksum = "md5:16f661fe971543ad9f2ee5ab98895c76"
    fresh_kde_iso_url = "https://mirror.yandex.ru/rosa/rosa2021.1/iso/ROSA.FRESH.12/plasma5/ROSA.FRESH.PLASMA5.12.5.1.x86_64.iso"
    fresh_kde_iso_checksum = "md5:7c901d9f7e8300e1cf729ce3078174f7"
}

source "qemu" "fresh-server" {
    iso_url = var.fresh_server_iso_url
    iso_checksum = var.fresh_server_iso_checksum
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
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rosa-fresh.cfg<F10>"
    ]
    shutdown_command = "sudo shutdown -P now"
}

source "virtualbox-iso" "fresh-server" {
    iso_url = var.fresh_server_iso_url
    iso_checksum = var.fresh_server_iso_checksum
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
    boot_command = [
        "<esc><wait>e",
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rosa-fresh.cfg<F10>"
    ]
    shutdown_command = "sudo shutdown -P now"
}

source "qemu" "fresh-kde" {
    iso_url = var.fresh_kde_iso_url
    iso_checksum = var.fresh_kde_iso_checksum
    shutdown_command = "sudo shutdown -P now"
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
        "<down><down><end> systemd.unit=anaconda.target inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rosa-fresh.cfg<F10>"
    ]
}

build {
    sources = [
        "source.qemu.fresh-server",
        "source.virtualbox-iso.fresh-server",
        "source.qemu.fresh-kde"
    ]
    provisioner "shell" {
        scripts = [
            "${path.root}/scripts/cleanup.sh",
            "${path.root}/scripts/upgrade.sh",
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
