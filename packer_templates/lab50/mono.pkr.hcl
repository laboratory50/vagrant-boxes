variables {
    boot_command = [
        "<esc><wait>",
        "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "debian-installer=en_US.UTF-8 ",
        "auto ",
        "locale=en_US.UTF-8 ",
        "kbd-chooser/method=us ",
        "keyboard-configuration/xkb-keymap=us ",
        "netcfg/get_hostname=bookworm ",
        "netcfg/get_domain=vagrantup.com ",
        "fb=false ",
        "debconf/frontend=noninteractive ",
        "console-setup/ask_detect=false ",
        "console-keymaps-at/keymap=us ",
        "<enter>"
    ]
    iso_url = "https://cdimage.debian.org/cdimage/release/12.6.0/amd64/iso-dvd/debian-12.6.0-amd64-DVD-1.iso"
    iso_checksum = "md5:462e540d1ba2ca5ecc68ab79c8e3788a"
}

source "qemu" "mono" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/bookworm.pkrtpl", {tasks = "ssh-server", boot = "/dev/vda"})
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

source "virtualbox-iso" "mono" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = 30000
    memory = 5120
    gfx_controller = "vmsvga"
    gfx_vram_size = 33
    guest_os_type = "Debian_64"
    guest_additions_path = "VBoxGuestAdditions_{{ .Version }}.iso"
    guest_additions_mode = "upload"
    guest_additions_interface = "sata"
    hard_drive_interface = "sata"
    iso_interface = "sata"
    vboxmanage = [["modifyvm", "{{.Name}}", "--audio", "none", "--nat-localhostreachable1", "on"]]
    virtualbox_version_file = ".vbox_version"
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/bookworm.pkrtpl", {tasks = "ssh-server", boot = "/dev/sda"})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "40m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "echo 'password' | sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.mono", "source.virtualbox-iso.mono"]
    provisioner "shell" {
        scripts = [
            "${path.root}/../debian/scripts/networking.sh",
            "${path.root}/../debian/scripts/ru-locale.sh",
            "${path.root}/../debian/scripts/cleanup.sh",
            "${path.root}/../debian/scripts/lab50-key.sh",
            "${path.root}/../common/vbox.sh",
            "${path.root}/../common/qemu.sh",
            "${path.root}/scripts/mono.sh",
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
