$server = "localhost"
$pool = "default"
$login = ENV["USER"]
$vms = {
    "smolensk-1.6" => "packer_templates/astralinux/qemu/smolensk-1.6.box",
    "smolensk-1.7" => "packer_templates/astralinux/qemu/smolensk-1.7.box",
    "smolensk-1.7-fly" => "packer_templates/astralinux/qemu/smolensk-1.7-fly.box",
    "smolensk-1.8" => "packer_templates/astralinux/qemu/smolensk-1.8.box",
    "smolensk-1.8-fly" => "packer_templates/astralinux/qemu/smolensk-1.8-fly.box",
    "aronia" => "packer_templates/basealt/qemu/aronia.box",
    "aronia-kde" => "packer_templates/basealt/qemu/aronia-kde.box",
    "salvia" => "packer_templates/basealt/qemu/salvia.box",
    "salvia-kde" => "packer_templates/basealt/qemu/salvia-kde.box",
    "bookworm" => "packer_templates/debian/qemu/bookworm.box",
    "bookworm-kde" => "packer_templates/debian/qemu/bookworm-kde.box",
    "gosjava11" => "packer_templates/lab50/gosjava11.box",
    "onyx" => "packer_templates/nppkt/qemu/onyx.box",
    "redos7" => "packer_templates/redsoft/qemu/murom.box",
    "redos7-mate" => "packer_templates/redsoft/qemu/murom-mate.box",
    "redos8" => "packer_templates/redsoft/eqmu/redos8.box",
    "redos8-kde" => "packer_templates/redsoft/qemu/redos8-kde.box",
    "rosa-fresh" => "packer_templates/rosa/qemu/fresh.box",
    "jammy" => "packer_templates/ubuntu/qemu/jammy.box",
    "noble" => "packer_templates/ubuntu/qemu/noble.box",
    "noble-kde" => "packer_templates/ubuntu/qemu/noble-kde.box",
    "openeuler2403" => "packer_templates/openeuler/qemu/openeuler2403.box",
    # Оригинальные образы.
    "orig-bullseye" => "debian/bullseye64",
    "orig-fedora" => "generic/fedora35"
}

# Анализ аргументов.
$command = ""
$name = ""
for arg in ARGV
    unless arg.start_with?("-")
        if $command.empty?
            $command = arg
        else
            $name = arg
            break
        end
    end
end

# Регистрируем тестовый бокс перед созданием ВМ.
if ($command == "up") and (not $name.empty?) and (not $name.start_with?("orig-"))
    unless $vms.key?($name)
        puts "Неизвестная ВМ #{$name}."
        exit(1)
    end

    libvirt_url = "qemu+tcp://#{$server}/system"
    box_path = $vms[$name]
    box_name = "test/" + File.basename(box_path, ".box")
    image = "test-VAGRANTSLASH-#{File.basename(box_path, ".box")}_vagrant_box_image_0_box.img"
    unless File.exists?(box_path)
        puts "Бокс #{box_path} не собран!"
        exit(1)
    end

    puts "Подготовка к созданию тестовой ВМ #{$name}..."
    system("virsh -c '#{libvirt_url}' vol-delete --pool #{$pool} #{image} 2> /dev/null")
    system("virsh -c '#{libvirt_url}' pool-refresh #{$pool}")
    system("vagrant box remove #{box_name}")
    system("vagrant box add --name=#{box_name} #{box_path}")
end

def register_vm(config, hostname, box_name)
    config.vm.define hostname, default: true do |node|
        node.vm.hostname = hostname
        node.vm.box = box_name
    end
end

Vagrant.configure("2") do |config|
    # Обшие настройки.
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.provider :libvirt do |libvirt|
        libvirt.host = $server
        libvirt.username = $login
        libvirt.uri = "qemu+tcp://" + $server + "/system"
        libvirt.storage_pool_name = $pool
        libvirt.memory = 5000
        libvirt.cpus = 3
        libvirt.graphics_type = "spice"
        libvirt.graphics_ip = "0.0.0.0"
        libvirt.channel :type => "spicevmc", :target_name => "com.redhat.spice.0", :target_type => "virtio"
        libvirt.redirdev :type => "spicevmc"
        libvirt.connect_via_ssh = true
        libvirt.default_prefix = ""
        libvirt.id_ssh_key_file = "/home/#{$login}/.ssh/id_rsa"
    end
    config.ssh.insert_key = false
    config.ssh.keep_alive = false

    # Регистрируем все ВМ на основе $vms.
    $vms.each do |hostname, box_path|
        box_name = box_path
        unless hostname.start_with?("orig-")
            box_name = "test/" + File.basename(box_path, ".box")
        end
        register_vm(config, hostname, box_name)
    end
end
