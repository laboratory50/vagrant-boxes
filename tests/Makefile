DEFAULT_CMD := cat /etc/os-release
ASTRA_CMD := cat /etc/astra_version
MONO_CMD := mono --version
GOSJAVA_CMD := java -version

.PHONY: aronia.libvirt aronia.vbox \
	bookworm.libvirt bookworm.vbox \
	fresh.libvirt fresh.vbox \
	gosjava11.libvirt gosjava11.vbox gosjava11.docker \
	jammy.libvirt jammy.vbox \
	mono.libvirt mono.vbox mono.docker \
	noble.libvirt noble.vbox \
	onyx.libvirt onyx.vbox onyx.docker \
	redos7.libvirt redos7.vbox \
	redos8.libvirt redos8.vbox \
	salvia.libvirt salvia.vbox \
	smolensk-1.7.libvirt \
	smolensk-1.8.libvirt

aronia.libvirt:
	@echo 'Creating Alt 10 vm using libvirt...'
	./test-vm.sh test-aronia Vagrantfile.libvirt "${DEFAULT_CMD}"

aronia.vbox:
	@echo 'Creating Alt 10 vm using VirtualBox...'
	./test-vm.sh test-aronia Vagrantfile.vbox "${DEFAULT_CMD}"

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
	./test-vm.sh test-gosjava11 Vagrantfile.libvirt "${GOSJAVA_CMD}"

gosjava11.vbox:
	@echo 'Creating ГосJava 11 vm using VirtualBox...'
	./test-vm.sh test-gosjava11 Vagrantfile.vbox "${GOSJAVA_CMD}"

gosjava11.docker:
	@echo 'Creating ГосJava 11 container...'
	docker container run --name test-gosjava11 lab50/gosjava11:latest ${GOSJAVA_CMD}
	docker rm test-gosjava11

jammy.libvirt:
	@echo 'Creating Ubuntu Jammy Jellyfish (22.04 LTS) vm using libvirt...'
	./test-vm.sh test-jammy Vagrantfile.libvirt "${DEFAULT_CMD}"

jammy.vbox:
	@echo 'Creating Ubuntu Jammy Jellyfish (22.04 LTS) vm using VirtualBox...'
	./test-vm.sh test-jammy Vagrantfile.vbox "${DEFAULT_CMD}"

mono.libvirt:
	@echo 'Creating MONO vm using libvirt...'
	./test-vm.sh test-mono Vagrantfile.libvirt "${MONO_CMD}"

mono.vbox:
	@echo 'Creating MONO vm using VirtualBox...'
	./test-vm.sh test-mono Vagrantfile.vbox "${MONO_CMD}"

mono.docker:
	@echo 'Creating MONO container...'
	docker container run --name test-mono lab50/mono:latest ${MONO_CMD}
	docker rm test-mono

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
	docker container run --name test-onyx nppct/onyx:latest ${DEFAULT_CMD}
	docker rm test-onyx

openeuler2403.libvirt:
	@echo 'Creating openEuler vm using libvirt...'
	./test-vm.sh test-openeuler2403 Vagrantfile.libvirt "${DEFAULT_CMD}"

openeuler2403.vbox:
	@echo 'Creating openEuler vm using VirtualBox...'
	./test-vm.sh test-openeuler2403 Vagrantfile.vbox "${DEFAULT_CMD}"

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

salvia.libvirt:
	@echo 'Creating Alt 11 vm using libvirt...'
	./test-vm.sh test-salvia Vagrantfile.libvirt "${DEFAULT_CMD}"

salvia.vbox:
	@echo 'Creating Alt 11 vm using VirtualBox...'
	./test-vm.sh test-salvia Vagrantfile.vbox "${DEFAULT_CMD}"

smolensk-1.7.libvirt:
	@echo 'Creating Astra 1.7 vm using libvirt...'
	./test-vm.sh test-smolensk-1.7 Vagrantfile.libvirt "${ASTRA_CMD}"

smolensk-1.8.libvirt:
	@echo 'Creating Astra 1.8 vm using libvirt...'
	./test-vm.sh test-smolensk-1.8 Vagrantfile.libvirt "${ASTRA_CMD}"
