DEFAULT_CMD := cat /etc/os-release

.PHONY: bookworm.libvirt bookworm.vbox \
	fresh.libvirt fresh.vbox \
	gosjava11.libvirt gosjava11.vbox gosjava11.docker \
	jammy.libvirt jammy.vbox \
	mono.libvirt mono.vbox mono.docker \
	noble.libvirt noble.vbox \
	onyx.libvirt onyx.vbox onyx.docker \
	redos7.libvirt redos7.vbox \
	redos8.libvirt redos8.vbox

bookworm.libvirt:
	@echo 'Creating Debian bookworm vm using libvirt...'
	./test-vm.sh test-bookworm Vagrantfile.libvirt "${DEFAULT_CMD}"

bookworm.vbox:
	@echo 'Creating Debian bookworm vm using VirtualBox...'
	./test-vm.sh test-bookworm Vagrantfile.vbox "${DEFAULT_CMD}"

fresh.libvirt:
	@echo 'Creating ROSA Fresh vm using libvirt...'
	./test-vm.sh test-fresh Vagrantfile.vbox "${DEFAULT_CMD}"

fresh.vbox:
	@echo 'Creating ROSA Fresh vm using VirtualBox...'
	./test-vm.sh test-fresh Vagrantfile.vbox "${DEFAULT_CMD}"

gosjava11.libvirt:
	@echo 'Creating ГосJava 11 vm using libvirt...'
	./test-vm.sh test-gosjava11 Vagrantfile.libvirt 'java -version'

gosjava11.vbox:
	@echo 'Creating ГосJava 11 vm using VirtualBox...'
	./test-vm.sh test-gosjava11 Vagrantfile.vbox 'java -version'

gosjava11.docker:
	@echo 'Creating ГосJava 11 container...'

jammy.libvirt:
	@echo 'Creating Ubuntu Jammy Jellyfish (22.04 LTS) vm using libvirt...'
	./test-vm.sh test-jammy Vagrantfile.libvirt "${DEFAULT_CMD}"

jammy.vbox:
	@echo 'Creating Ubuntu Jammy Jellyfish (22.04 LTS) vm using VirtualBox...'
	./test-vm.sh test-jammy Vagrantfile.vbox "${DEFAULT_CMD}"

mono.libvirt:
	@echo 'Creating MONO vm using libvirt...'
	./test-vm.sh test-mono Vagrantfile.libvirt 'mono --version'

mono.vbox:
	@echo 'Creating MONO vm using VirtualBox...'
	./test-vm.sh test-mono Vagrantfile.vbox 'mono --version'

mono.docker:
	@echo 'Creating MONO container...'

noble.libvirt:
	@echo 'Creating Ubuntu Noble Numbat (24.04 LTS) vm using libvirt...'
	./test-vm.sh test-noble Vagrantfile.libvirt "${DEFAULT_CMD}"

noble.vbox:
	@echo 'Creating Ubuntu Noble Numbat (24.04 LTS) vm using VirtualBox...'
	./test-vm.sh test-noble Vagrantfile.vbox c"${DEFAULT_CMD}"

onyx.libvirt:
	@echo 'Creating OSnova vm using libvirt...'
	./test-vm.sh test-onyx Vagrantfile.libvirt "${DEFAULT_CMD}"

onyx.vbox:
	@echo 'Creating OSnova vm using VirtualBox...'
	./test-vm.sh test-onyx Vagrantfile.vbox "${DEFAULT_CMD}"

onyx.docker:
	@echo 'Creating OSnova container...'

redos7.libvirt:
	@echo 'Creating РЕД ОС 7 vm using libvirt...'
	./test-vm.sh test-redos7 Vagrantfile.libvirt "${DEFAULT_CMD}"

redos7.vbox:
	@echo 'Creating РЕД ОС 7 vm using VirtualBox...'
	./test-vm.sh test-redos7 Vagrantfile.vbox "${DEFAULT_CMD}"

redos8.libvirt:
	@echo 'Creating РЕД ОС 8 vm using libvirt...'
	./test-vm.sh test-redos8 Vagrantfile.libvirt "${DEFAULT_CMD}"

redos8.vbox:
	@echo 'Creating РЕД ОС 8 vm using VirtualBox...'
	./test-vm.sh test-redos8 Vagrantfile.vbox "${DEFAULT_CMD}"
