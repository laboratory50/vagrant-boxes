variables {
    iso_url = "https://files.red-soft.ru/redos/7.3/x86_64/iso/redos-MUROM-7.3.4-20231220.0-Everything-x86_64-DVD1.iso"
    iso_checksum = "md5:a8ca7c2c1b39f8d9ca75d2118457e5dd"
}

source "qemu" "redos7" {
    iso_url = var.iso_url 
    iso_checksum = var.iso_checksum 
    shutdown_command = "echo 'password' | sudo -S shutdown -P now"
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/redos7.pkrtpl", {groups = ["base", "core"]})
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
}

source "virtualbox-iso" "redos7" {
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
        "/ks.cfg" = templatefile("${path.root}/redos7.pkrtpl", {groups = []})
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


source "qemu" "redos7-mate" {
    iso_url = var.iso_url 
    iso_checksum = var.iso_checksum 
    shutdown_command = "echo 'password' | sudo -S shutdown -P now"
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/redos7.pkrtpl", {groups = ["base", "core", "fonts", "mate-desktop", "x11"]})
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
}

build {
    sources = ["source.qemu.redos7", "source.virtualbox-iso.redos7", "source.qemu.redos7-mate"]
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
