$libvirt_uri = "qemu:///system"
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
    "redos7" => "packer_templates/redsoft/qemu/redos7.box",
    "redos7-mate" => "packer_templates/redsoft/qemu/redos7-mate.box",
    "redos8" => "packer_templates/redsoft/qemu/redos8.box",
    "redos8-kde" => "packer_templates/redsoft/qemu/redos8-kde.box",
    "rosa-fresh" => "packer_templates/rosa/qemu/fresh-server.box",
    "jammy" => "packer_templates/ubuntu/qemu/jammy.box",
    "noble" => "packer_templates/ubuntu/qemu/noble.box",
    "noble-kde" => "packer_templates/ubuntu/qemu/noble-kde.box",
    "openeuler2403" => "packer_templates/openeuler/qemu/openeuler2403.box",
    # Оригинальные образы.
    "orig-bullseye" => "debian/bullseye64",
    "orig-fedora" => "generic/fedora35"
}

def is_box_registered(box_name)
    box_list_output = `vagrant box list`
    return box_list_output.include? "#{box_name} "
end

def delete_box(box_name)
    system("vagrant box remove --all #{box_name} > /dev/null")
    image_prefix = box_name.gsub("/", "-VAGRANTSLASH-") + "_vagrant_box_image_"
    vol_list_output = `virsh -c '#{$libvirt_uri}' vol-list default | awk '{print $1}'`
    vol_list_output.split("\n").each do |line|
        if line.include? image_prefix
            puts "В хранилище libvirt обнаружен #{line}."
            system("virsh -c '#{$libvirt_uri}' vol-delete --pool #{$pool} #{line} > /dev/null")
        end
    end
    system("virsh -c '#{$libvirt_uri}' pool-refresh #{$pool} > /dev/null")
end

def register_vm(config, hostname, box_name)
    config.vm.define hostname, default: true do |node|
        node.vm.hostname = hostname
        node.vm.box = box_name
    end
end

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
    box_path = $vms[$name]
    unless File.exists?(box_path)
        puts "Бокс #{box_path} не собран!"
        exit(1)
    end

    
    box_name = "test/" + File.basename(box_path, ".box")
    puts "Подготовка к созданию ВМ #{$name}. Тестовый бокс: #{box_name}."
    if is_box_registered(box_name)
        delete_box(box_name)
    end
    # Регистрация тестового бокса.
    system("vagrant box add --name=#{box_name} #{box_path}")
end

Vagrant.configure("2") do |config|
    # Обшие настройки.
    config.vm.synced_folder ".", "/vagrant", disabled: true
    config.vm.provider :libvirt do |libvirt|
        libvirt.uri = $libvirt_uri
        libvirt.storage_pool_name = $pool
        libvirt.memory = 5000
        libvirt.cpus = 3
        libvirt.graphics_type = "spice"
        libvirt.graphics_ip = "0.0.0.0"
        libvirt.channel :type => "spicevmc", :target_name => "com.redhat.spice.0", :target_type => "virtio"
        libvirt.redirdev :type => "spicevmc"
        libvirt.default_prefix = ""
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
