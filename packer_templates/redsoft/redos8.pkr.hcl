variables {
    iso_url = "https://files.red-soft.ru/redos/8.0/x86_64/iso/redos-8-20240218.1-Everything-x86_64-DVD1.iso"
    iso_checksum = "md5:49c93e5c4ec8cef4ce44386af072b1b7"
}

source "qemu" "redos8" {
    iso_url = var.iso_url 
    iso_checksum = var.iso_checksum 
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/redos8.pkrtpl", {groups = []})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "50m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = [
        "<up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
    ]
    shutdown_command = "echo 'password' | sudo -S shutdown -P now"
}

source "virtualbox-iso" "redos8" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
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
    vboxmanage = [[
      "modifyvm",
      "{{.Name}}",
      "--audio",
      "none",
      "--nat-localhostreachable1",
      "on",
    ]]
    virtualbox_version_file = ".vbox_version"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/redos8.pkrtpl", {groups = []})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "50m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = [
        "<up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
    ]
    shutdown_command = "echo 'password' | sudo -S shutdown -P now"
}

source "qemu" "redos8-kde" {
    iso_url = var.iso_url 
    iso_checksum = var.iso_checksum 
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/redos8.pkrtpl", {groups = ["core", "kde-desktop"]})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "50m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = [
        "<up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
    ]
    shutdown_command = "echo 'password' | sudo -S shutdown -P now"
}

build {
    sources = ["source.qemu.redos8", "source.virtualbox-iso.redos8", "source.qemu.redos8-kde"]
    provisioner "shell" {
        scripts = [
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
