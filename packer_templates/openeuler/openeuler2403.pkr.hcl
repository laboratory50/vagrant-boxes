# openEuler 24.03 LTS.
variables {
    boot_command = [
        "<up><tab><wait><end> inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter>"
    ]
    iso_url = "https://mirror.truenetwork.ru/openeuler/openEuler-24.03-LTS/ISO/x86_64/openEuler-24.03-LTS-x86_64-dvd.iso"
    iso_checksum = "sha256:786b9683659512e71c978c34aea806a97ed6cacf04e1b0a22017a50eec582cbe"
}

source "qemu" "openeuler2403" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    cpu_model = "host"
    memory = 4096
    disk_size = "30000M"     
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/ks.cfg" = templatefile("${path.root}/openeuler2403.pkrtpl", {groups = []})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "35m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

source "virtualbox-iso" "openeuler2403" {
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
        "/ks.cfg" = templatefile("${path.root}/openeuler2403.pkrtpl", {groups = []})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "40m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.openeuler2403", "source.virtualbox-iso.openeuler2403"]
    provisioner "shell" {
        scripts = [
            # "${path.root}/../debian/scripts/ru-locale.sh",
            # "${path.root}/../debian/scripts/lab50-key.sh",
            # "${path.root}/../common/vbox.sh",
            # "${path.root}/../common/qemu.sh",
            # "${path.root}/../debian/scripts/cleanup.sh",
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
