.PHONY: all clean \
	astralinux \
	smolensk-1.6 smolensk-1.7 smolensk-fly-1.7 orel-1.7 \
	smolensk-1.8.libvirt \
	smolensk-fly-1.8.libvirt \
	basealt \
	aronia.libvirt aronia.vbox \
	salvia.libvirt salvia.vbox \
	salvia-kde.libvirt \
	debian \
	bookworm.libvirt bookworm.vbox \
	bookworm-kde.libvirt \
	fedora fedora38 fedora38-kde fedora39 fedora39-kde fedora40 fedora40-kde \
	lab50 \
	gosjava11.libvirt gosjava11.vbox \
	mono.libvirt mono.vbox \
	nppkt onyx onyx-kde \
	redsoft \
	redos7.libvirt redos7.vbox \
	redos7-mate.libvirt \
	redos8.libvirt redos8.vbox \
	redos8-kde.libvirt \
	rosa \
	fresh-server.libvirt fresh-server.vbox \
	fresh-kde.libvirt \
	chrome-kde cobalt \
	ubuntu \
	jammy.libvirt jammy.vbox \
	noble.libvirt noble.vbox \
	noble-kde.libvirt \
	openeuler2403.libvirt

all: astralinux basealt debian fedora lab50 nppkt redsoft rosa ubuntu

clean:
	rm -rf packer_templates/astralinux/qemu
	rm -f packer_templates/basealt/*.box
	rm -rf packer_templates/debian/qemu
	rm -rf packer_templates/debian/virtualbox-iso
	rm -f packer_templates/fedora/*.box
	rm -rf packer_templates/lab50/qemu
	rm -rf packer_templates/lab50/virtualbox-iso
	rm -f packer_templates/nppkt/*.box
	rm -rf packer_templates/redsoft/qemu
	rm -rf packer_templates/redsoft/virtualbox-iso
	rm -rf packer_templates/rosa/qemu
	rm -rf packer_templates/rosa/virtualbox-iso
	rm -rf packer_templates/ubuntu/qemu
	rm -rf packer_templates/ubuntu/virtualbox-iso

astralinux: smolensk-1.6 smolensk-1.7 smolensk-fly-1.7 orel-1.7 smolensk-1.8.libvirt smolensk-fly-1.8.libvirt

smolensk-1.6:
	rm -f packer_templates/astralinux/qemu/smolensk-1.6.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.6.pkr.hcl

smolensk-fly-1.6:
	rm -f packer_templates/astralinux/qemu/smolensk-fly-1.6.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.6.pkr.hcl

smolensk-1.7:
	rm -f packer_templates/astralinux/qemu/smolensk-1.7.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.7.pkr.hcl

smolensk-fly-1.7:
	rm -f packer_templates/astralinux/qemu/smolensk-fly-1.7.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.7.pkr.hcl

orel-1.7:
	rm -f packer_templates/astralinux/qemu/orel-1.7.box
	cd packer_templates/astralinux; packer build -only qemu.orel astra-1.7.pkr.hcl

smolensk-1.8.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-1.8.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk astra-1.8.pkr.hcl

smolensk-fly-1.8.libvirt:
	rm -f packer_templates/astralinux/qemu/smolensk-fly-1.8.box
	cd packer_templates/astralinux; packer build -only qemu.smolensk-fly astra-1.8.pkr.hcl

basealt: aronia.libvirt aronia.vbox salvia.libvirt salvia.vbox salvia-kde.libvirt

aronia.libvirt:
	rm -f packer_templates/basealt/qemu/aronia.box
	cd packer_templates/basealt; packer build -only qemu.aronia aronia.pkr.hcl

aronia.vbox:
	rm -f packer_templates/basealt/virtualbox-iso/aronia.box
	cd packer_templates/basealt; packer build -only virtualbox-iso.aronia aronia.pkr.hcl

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

mono.libvirt:
	rm -f packer_templates/lab50/qemu/mono.box
	cd packer_templates/lab50; packer build -only qemu.mono mono.pkr.hcl

mono.vbox:
	rm -f packer_templates/lab50/virtualbox-iso/mono.box
	cd packer_templates/lab50; packer build -only virtualbox-iso.mono mono.pkr.hcl

nppkt: onyx onyx-kde

onyx:
	rm -f packer_templates/nppkt/onyx.box
	cd packer_templates/nppkt; packer build -only qemu.onyx onyx.pkr.hcl

onyx-kde:
	rm -f packer_templates/nppkt/onyx-kde.box
	cd packer_templates/nppkt; packer build -only qemu.onyx-kde onyx.pkr.hcl

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

rosa: fresh-server.libvirt fresh-server.vbox fresh-kde.libvirt chrome-kde cobalt

fresh-server.libvirt:
	rm -f packer_templates/rosa/qemu/fresh-server.box
	cd packer_templates/rosa; packer build -only qemu.fresh-server rosa.pkr.hcl

fresh-server.vbox:
	rm -f packer_templates/rosa/virtualbox-iso/fresh-server.box
	cd packer_templates/rosa; packer build -only virtualbox-iso.fresh-server rosa.pkr.hcl

fresh-kde.libvirt:
	rm -f packer_templates/rosa/qemu/fresh-kde.box
	cd packer_templates/rosa; packer build -only qemu.fresh-kde rosa.pkr.hcl

chrome-kde:
	rm -f packer_templates/rosa/qemu/chrome-kde.box
	cd packer_templates/rosa; packer build -only qemu.chrome-kde rosa.pkr.hcl

cobalt:
	rm -f packer_templates/rosa/qemu/cobalt.box
	cd packer_templates/rosa; packer build -only qemu.cobalt rosa.pkr.hcl

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

openeuler2403.libvirt:
	rm -f packer_templates/openeuler/qemu/openeuler2403.box
	cd packer_templates/openeuler; packer build -only qemu.openeuler2403 openeuler2403.pkr.hcl
