#!/bin/bash
# Creats a vm. Supportive script for the Makefile.
set -e

vagrant_boxes_dir="${HOME}/.vagrant.d/boxes"
libvirt_pool=default
default_cmd='cat /etc/os-release'

vm="$1"
vagrantfile="$2"
cmd="$3"
image=`jq -r ".\"${vm}\".image" ./images.json`

# Cleanup step 1: dealing with the Vagrant cache.
box_dir_name=`echo "${image}" | sed 's|/|-VAGRANTSLASH-|'`
if [ -d "${vagrant_boxes_dir}/${box_dir_name}" ]
then
    rm -rf ${vagrant_boxes_dir}/${box_dir_name}
    echo "Directory ${vagrant_boxes_dir}/${box_dir_name} is gone."
fi

# Cleanup step 2: dealing with the libvirt cache.
if virsh --connect qemu:///system vol-list "${libvirt_pool}" | grep --quiet "${box_dir_name}"
then
    virsh --connect qemu:///system vol-list "${libvirt_pool}" | grep "${box_dir_name}" | awk '{print $1}' | xargs -I {} virsh --connect qemu:///system vol-delete --pool "${libvirt_pool}" {}
fi

# Add local image to the libvirt cache if necessary.
if [ ! -n "${VAGRANT_SERVER_URL}" ]
then
    echo 'Environment variable VAGRANT_SERVER_URL not found, therefore using local boxes.'
    if [ "${vagrantfile}" == "Vagrantfile.libvirt" ]
    then
        local_image=`jq -r ".\"${vm}\".local_libvirt_image" ./images.json`
    else
        local_image=`jq -r ".\"${vm}\".local_vbox_image" ./images.json`
    fi
    if [ ! -f "../${local_image}" ]
    then
        echo "${local_image} is absent. Build first."
        exit 1
    fi
    echo "Using the local box ${local_image}."
    vagrant box add --name="${image}" "../${local_image}"
fi

# Test!
VAGRANT_VAGRANTFILE="${vagrantfile}" vagrant up "${vm}"
VAGRANT_VAGRANTFILE="${vagrantfile}" vagrant ssh --command "${cmd}" "${vm}"
VAGRANT_VAGRANTFILE="${vagrantfile}" vagrant destroy -f "${vm}"
