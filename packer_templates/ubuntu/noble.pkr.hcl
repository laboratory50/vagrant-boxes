# Ubuntu 24.04 LTS (Noble Numbat).
variables {
    boot_command = [
        "<wait>e<wait><down><down><down><end>",
        " autoinstall ds=nocloud-net\\;s=http://{{.HTTPIP}}:{{.HTTPPort}}/<wait><f10><wait>"
    ]
    iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04-live-server-amd64.iso"
    iso_checksum = "md5:b33b57dea8c827febc89f38b31d532e6"
}

source "qemu" "noble" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/user-data" = templatefile("${path.root}/noble.pkrtpl", {packages = []}),
        "/meta-data" = ""
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "20m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "virtualbox-iso" "noble" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = 30000
    memory = 5120
    gfx_controller = "vmsvga"
    gfx_vram_size = 33
    guest_os_type = "Ubuntu_64"
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
        "/user-data" = templatefile("${path.root}/noble.pkrtpl", {packages = []}),
        "/meta-data" = ""
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "30m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "qemu" "noble-kde" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/user-data" = templatefile("${path.root}/noble.pkrtpl", {packages = ["kde-full"]}),
        "/meta-data" = ""
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "60m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.noble", "source.virtualbox-iso.noble", "source.qemu.noble-kde"]
    provisioner "shell" {
        inline = [
            "sudo sed -i 's/ens3:/ens7:/g' /etc/netplan/50-cloud-init.yaml"
        ]
    }
    provisioner "shell" {
        scripts = [
            # "${path.root}/../debian/scripts/ru-locale.sh",
            "${path.root}/../debian/scripts/lab50-key.sh",
            "${path.root}/../common/vbox.sh",
            "${path.root}/../common/qemu.sh",
            # "${path.root}/../debian/scripts/cleanup.sh",
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
        vagrantfile_template = "files/Vagrantfile"
    }
}
