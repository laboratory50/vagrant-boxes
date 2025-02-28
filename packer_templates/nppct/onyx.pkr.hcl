variables {
    boot_command = [
        "<down><wait><esc><wait><enter><wait>",
        "install preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "debian-installer=en_US.UTF-8 ",
        "auto ",
        "locale=en_US.UTF-8 ",
        "debian-installer/language=en ",
        "kbd-chooser/method=us ",
        "keyboard-configuration/xkb-keymap=us ",
        "netcfg/get_hostname=onyx ",
        "netcfg/get_domain=vagrantup.com ",
        "fb=false ",
        "debconf/frontend=noninteractive ",
        "console-setup/ask_detect=false ",
        "osnova-license/license=true",
        "<enter>"
    ]
    iso_url = "onyx3-3.0-disk1-25.11.2024_14.34.iso"
    iso_checksum = "md5:ecefec2e0ebb482088ea81664cbc639e"
}

source "qemu" "onyx" {
    iso_url = var.iso_url
    iso_checksum = var.iso_checksum
    disk_size = "30000M"
    memory = 5120
    format = "qcow2"
    accelerator = "kvm"
    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/onyx.pkrtpl", {tasks="ssh-server", boot="/dev/vda"})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "35m"
    vm_name = "${source.name}"
    net_device = "virtio-net"
    disk_interface = "virtio"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "echo 'password' | sudo -S /sbin/shutdown -hP now"
}

source "virtualbox-iso" "onyx" {
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
        "/preseed.cfg" = templatefile("${path.root}/onyx.pkrtpl", {tasks="ssh-server", boot="/dev/sda"})
    }
    ssh_username = "vagrant"
    ssh_password = "password"
    ssh_timeout = "70m"
    vm_name = "${source.name}"
    boot_wait = "5s"
    boot_command = var.boot_command
    shutdown_command = "echo 'password' | sudo -S /sbin/shutdown -hP now"
}

build {
    sources = ["source.qemu.onyx", "source.virtualbox-iso.onyx"]
    provisioner "shell" {
        scripts = [
            "${path.root}/../debian/scripts/ru-locale.sh",
            "${path.root}/../debian/scripts/lab50-key.sh",
            # "${path.root}/../common/vbox.sh",
            # "${path.root}/../common/qemu.sh",
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
