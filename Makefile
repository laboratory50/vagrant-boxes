ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: all clean \
	astralinux \
	smolensk-1.6.libvirt \
	smolensk-1.7.libvirt smolensk-1.7-fly.libvirt \
	smolensk-1.8.libvirt smolensk-1.8-fly.libvirt \
	basealt \
	aronia.libvirt aronia.vbox \
	aronia-kde.libvirt \
	salvia.libvirt salvia.vbox \
	salvia-kde.libvirt \
	debian \
	bookworm.libvirt bookworm.vbox \
	bookworm-kde.libvirt \
	fedora fedora38 fedora38-kde fedora39 fedora39-kde fedora40 fedora40-kde \
	lab50 \
	gosjava11.libvirt gosjava11.vbox gosjava11.docker \
	mono.libvirt mono.vbox mono.docker \
	nppkt \
	onyx.libvirt onyx.vbox \
	onyx.docker \
	redsoft \
	redos7.libvirt redos7.vbox \
	redos7-mate.libvirt \
	redos8.libvirt redos8.vbox \
	redos8-kde.libvirt \
	rosa \
	fresh.libvirt fresh.vbox \
	fresh.docker \
	fresh-kde.libvirt \
	chrome-kde cobalt \
	ubuntu \
	jammy.libvirt jammy.vbox \
	noble.libvirt noble.vbox \
	noble-kde.libvirt \
	openeuler2403 \
	openeuler2403.libvirt openeuler2403.vbox

all: astralinux basealt debian fedora lab50 nppkt redsoft rosa ubuntu

clean:
	rm -rf packer_templates/astralinux/qemu
	rm -rf packer_templates/basealt/qemu
	rm -rf packer_templates/basealt/virtualbox-iso
	rm -rf packer_templates/debian/qemu
	rm -rf packer_templates/debian/virtualbox-iso
	rm -f packer_templates/fedora/*.box
	rm -rf packer_templates/lab50/qemu
	rm -rf packer_templates/lab50/virtualbox-iso
	rm -rf packer_templates/nppkt/qemu
	rm -rf packer_templates/redsoft/qemu
	rm -rf packer_templates/redsoft/virtualbox-iso
	rm -rf packer_templates/rosa/qemu
	rm -rf packer_templates/rosa/virtualbox-iso
	rm -rf packer_templates/ubuntu/qemu
	rm -rf packer_templates/ubuntu/virtualbox-iso

astralinux: smolensk-1.6.libvirt smolensk-1.6-fly.libvirt smolensk-1.7.libvirt smolensk-1.7-fly.libvirt smolensk-1.8.libvirt smolensk-1.8-fly.libvirt

smolensk-1.6.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.6.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.6.pkr.hcl

smolensk-1.6-fly.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.6-fly.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.6.pkr.hcl

smolensk-1.7.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.7.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.7.pkr.hcl

smolensk-1.7-fly.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.7-fly.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.7.pkr.hcl

smolensk-1.8.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.8.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.8.pkr.hcl

smolensk-1.8-fly.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.8-fly.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.8.pkr.hcl

basealt: aronia.libvirt aronia.vbox aronia-kde.libvirt salvia.libvirt salvia.vbox salvia-kde.libvirt

aronia.libvirt:
	rm -f packer_templates/basealt/qemu/aronia.box
	cd packer_templates/basealt; packer build -only qemu.aronia aronia.pkr.hcl

aronia.vbox:
	rm -f packer_templates/basealt/virtualbox-iso/aronia.box
	cd packer_templates/basealt; packer build -only virtualbox-iso.aronia aronia.pkr.hcl

aronia-kde.libvirt:
	rm -f packer_templates/basealt/qemu/aronia-kde.box
	cd packer_templates/basealt; packer build -only qemu.aronia-kde aronia.pkr.hcl

salvia.libvirt:
	rm -f packer_templates/basealt/qemu/salvia.box
	cd packer_templates/basealt; packer build -only qemu.salvia salvia.pkr.hcl

salvia.vbox:
	rm -f packer_templates/basealt/virtualbox-iso/salvia.box
	cd packer_templates/basealt; packer build -only virtualbox-iso.salvia salvia.pkr.hcl

salvia-kde.libvirt:
	rm -f packer_templates/basealt/qemu/salvia-kde.box
	cd packer_templates/basealt; packer build -only qemu.salvia-kde salvia.pkr.hcl

debian: bookworm.libvirt bookworm.vbox bookworm-kde.libvirt

bookworm.libvirt:
	rm -f packer_templates/debian/qemu/bookworm.box
	cd packer_templates/debian; packer build -only qemu.bookworm bookworm.pkr.hcl

bookworm.vbox:
	rm -f packer_templates/debian/virtualbox-iso/bookworm.box
	cd packer_templates/debian; packer build -only virtualbox-iso.bookworm bookworm.pkr.hcl

bookworm-kde.libvirt:
	rm -f packer_templates/debian/qemu/bookworm-kde.box
	cd packer_templates/debian; packer build -only qemu.bookworm-kde bookworm.pkr.hcl

fedora: fedora38 fedora38-kde fedora39 fedora39-kde fedora40 fedora40-kde

fedora38:
	rm -f packer_templates/fedora/fedora38.box
	cd packer_templates/fedora; packer build -only qemu.fedora38 fedora38.pkr.hcl

fedora38-kde:
	rm -f packer_templates/fedora/fedora38-kde.box
	cd packer_templates/fedora; packer build -only qemu.fedora38-kde fedora38.pkr.hcl

fedora39:
	rm -f packer_templates/fedora/fedora39.box
	cd packer_templates/fedora; packer build -only qemu.fedora39 fedora39.pkr.hcl

fedora39-kde:
	rm -f packer_templates/fedora/fedora39-kde.box
	cd packer_templates/fedora; packer build -only qemu.fedora39-kde fedora39.pkr.hcl

fedora40:
	rm -f packer_templates/fedora/fedora40.box
	cd packer_templates/fedora; packer build -only qemu.fedora40 fedora40.pkr.hcl

fedora40-kde:
	rm -f packer_templates/fedora/fedora40-kde.box
	cd packer_templates/fedora; packer build -only qemu.fedora40-kde fedora40.pkr.hcl

lab50: gosjava11.libvirt gosjava11.vbox mono.libvirt mono.vbox

gosjava11.libvirt:
	rm -f packer_templates/lab50/qemu/gosjava11.box
	cd packer_templates/lab50; packer build -only qemu.gosjava11 gosjava.pkr.hcl

gosjava11.vbox:
	rm -f packer_templates/lab50/virtualbox-iso/gosjava11.box
	cd packer_templates/lab50; packer build -only virtualbox-iso.gosjava11 gosjava.pkr.hcl

gosjava11.docker:
	$(eval LAB50_DIR = "${ROOT_DIR}/docker/lab50")
	$(eval CREATED = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
	docker build -f "${LAB50_DIR}/Dockerfile.gosjava11" -t lab50/gosjava11 --build-arg "created=${CREATED}" "${LAB50_DIR}"

mono.libvirt:
	rm -f packer_templates/lab50/qemu/mono.box
	cd packer_templates/lab50; packer build -only qemu.mono mono.pkr.hcl

mono.vbox:
	rm -f packer_templates/lab50/virtualbox-iso/mono.box
	cd packer_templates/lab50; packer build -only virtualbox-iso.mono mono.pkr.hcl

mono.docker:
	$(eval LAB50_DIR = "${ROOT_DIR}/docker/lab50")
	$(eval CREATED = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
	docker build -f "${LAB50_DIR}/Dockerfile.mono" -t lab50/mono --build-arg "created=${CREATED}" "${LAB50_DIR}"

nppkt: onyx.libvirt onyx.vbox

onyx.libvirt:
	rm -f packer_templates/nppkt/qemu/onyx.box
	cd packer_templates/nppkt; packer build -only qemu.onyx onyx.pkr.hcl

onyx.vbox:
	rm -f packer_templates/nppkt/virtualbox-iso/onyx.box
	cd packer_templates/nppkt; packer build -only virtualbox-iso.onyx onyx.pkr.hcl

onyx.docker:
ifneq ($(shell id -u), 0)
	@echo 'You are not root.'
	exit 1
endif
ifndef OSNOVA_CREDENTIALS
	@echo 'Environment variable OSNOVA_CREDENTIALS not found.'
	exit 1
endif
	$(eval NPPKT_DIR = "${ROOT_DIR}/docker/nppkt")
	$(eval INSTALLROOT = "${NPPKT_DIR}/installroot")
	@echo "Building in ${INSTALLROOT}..."
	rm -rf "${INSTALLROOT}"
	mmdebstrap --mode=unshare --keyring="${NPPKT_DIR}/osnova.asc" --include=systemd-container --aptopt='APT::Install-Recommends false' --aptopt='APT::AutoRemove::SuggestsImportant false' --aptopt='APT::AutoRemove::RecommendsImportant false' --aptopt='Acquire::Languages "none"' --merged-usr --components=main,contrib,non-free onyx "${INSTALLROOT}" "https://${OSNOVA_CREDENTIALS}@dl.nppct.ru/onyx/stable/repos/disk1"
	echo '' > "${INSTALLROOT}/etc/apt/sources.list"
	@echo "Creating a docker image..."
	$(eval CREATED = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
	docker build -f "${NPPKT_DIR}/Dockerfile" -t nppkt/onyx --build-arg "created=${CREATED}" "${INSTALLROOT}"

redsoft: redos7.libvirt redos7.vbox redos7-mate.libvirt redos8.libvirt redos8.vbox redos8-kde.libvirt

redos7.libvirt:
	rm -f packer_templates/redsoft/qemu/redos7.box
	cd packer_templates/redsoft; packer build -only qemu.redos7 redos7.pkr.hcl

redos7.vbox:
	rm -f packer_templates/redsoft/virtualbox-iso/redos7.box
	cd packer_templates/redsoft; packer build -only virtualbox-iso.redos7 redos7.pkr.hcl

redos7-mate.libvirt:
	rm -f packer_templates/redsoft/qemu/redos7-mate.box
	cd packer_templates/redsoft; packer build -only qemu.redos7-mate redos7.pkr.hcl

redos8.libvirt:
	rm -f packer_templates/redsoft/qemu/redos8.box
	cd packer_templates/redsoft; packer build -only qemu.redos8 redos8.pkr.hcl

redos8.vbox:
	rm -f packer_templates/redsoft/virtualbox-iso/redos8.box
	cd packer_templates/redsoft; packer build -only virtualbox-iso.redos8 redos8.pkr.hcl

redos8-kde.libvirt:
	rm -f packer_templates/redsoft/qemu/redos8-kde.box
	cd packer_templates/redsoft; packer build -only qemu.redos8-kde redos8.pkr.hcl

rosa: fresh.libvirt fresh.vbox fresh-kde.libvirt

fresh.libvirt:
	rm -f packer_templates/rosa/qemu/fresh-server.box
	cd packer_templates/rosa; packer build -only qemu.fresh-server rosa.pkr.hcl

fresh.vbox:
	rm -f packer_templates/rosa/virtualbox-iso/fresh-server.box
	cd packer_templates/rosa; packer build -only virtualbox-iso.fresh-server rosa.pkr.hcl

fresh.docker:
ifneq ($(shell id -u), 0)
	@echo 'You are not root.'
	exit 1
endif
	$(eval ROSA_DIR = "${ROOT_DIR}/docker/rosa")
	$(eval INSTALLROOT = "${ROSA_DIR}/installroot")
	$(eval PACKAGES = branding-configs-fresh-desktop systemd util-linux rootfiles)
	@echo "Building in ${INSTALLROOT}..."
	rm -rf "${INSTALLROOT}"
	dnf install -y --nogpgcheck --releasever 2021.1 --config "${ROSA_DIR}/rosa-main-x86_64.repo" --installroot "${INSTALLROOT}" ${PACKAGES}
	@echo "Creating a docker image..."
	$(eval CREATED = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ"))
	docker build -f "${ROSA_DIR}/Dockerfile" -t rosa/2021.1-fresh --build-arg "created=${CREATED}" "${INSTALLROOT}"

fresh-kde.libvirt:
	rm -f packer_templates/rosa/qemu/fresh-kde.box
	cd packer_templates/rosa; packer build -only qemu.fresh-kde rosa.pkr.hcl

ubuntu: jammy.libvirt jammy.vbox noble.libvirt noble.vbox noble-kde.libvirt

jammy.libvirt:
	rm -f packer_templates/ubuntu/qemu/jammy.box
	cd packer_templates/ubuntu; packer build -only qemu.jammy jammy.pkr.hcl

jammy.vbox:
	rm -f packer_templates/ubuntu/virtualbox-iso/jammy.box
	cd packer_templates/ubuntu; packer build -only virtualbox-iso.jammy jammy.pkr.hcl

noble.libvirt:
	rm -f packer_templates/ubuntu/qemu/noble.box
	cd packer_templates/ubuntu; packer build -only qemu.noble noble.pkr.hcl

noble.vbox:
	rm -f packer_templates/ubuntu/virtualbox-iso/noble.box
	cd packer_templates/ubuntu; packer build -only virtualbox-iso.noble noble.pkr.hcl

noble-kde.libvirt:
	rm -f packer_templates/ubuntu/qemu/noble-kde.box
	cd packer_templates/ubuntu; packer build -only qemu.noble-kde noble.pkr.hcl

openeuler2403: openeuler2403.libvirt openeuler2403.vbox

openeuler2403.libvirt:
	rm -f packer_templates/openeuler/qemu/openeuler2403.box
	cd packer_templates/openeuler; packer build -only qemu.openeuler2403 openeuler2403.pkr.hcl

openeuler2403.vbox:
	rm -f packer_templates/openeuler/virtualbox-iso/openeuler2403.box
	cd packer_templates/openeuler; packer build -only virtualbox-iso.openeuler2403 openeuler2403.pkr.hcl
