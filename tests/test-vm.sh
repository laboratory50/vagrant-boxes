#!/bin/bash
# Creats a vm. Helper script for the Makefile.
set -e

vagrant_boxes_dir="${HOME}/.vagrant.d/boxes"
libvirt_pool=default
default_cmd='cat /etc/os-release'

vm="$1"
vagrantfile="$2"
cmd="$3"
image=`jq -r ".\"${vm}\"" images.json`
if [ "${image}" == 'null' ]
then
    echo "Unknown vm ${vm}."
    exit 1
fi
if ! jq -e "has(\"${image}\")" ../descriptions.json > /dev/null
then
    echo "Unknown image ${image}."
    exit 1
fi

# Cleanup step 1: dealing with the Vagrant cache.
box_dir_name=`echo "${image}" | sed 's|/|-VAGRANTSLASH-|'`
if [ -d "${vagrant_boxes_dir}/${box_dir_name}" ]
then
    rm -rf "${vagrant_boxes_dir}/${box_dir_name}"
    echo "Directory ${vagrant_boxes_dir}/${box_dir_name} is gone."
fi

# Cleanup step 2: dealing with the libvirt cache.
if virsh --connect qemu:///system vol-list "${libvirt_pool}" | grep --quiet "${box_dir_name}"
then
    virsh --connect qemu:///system vol-list "${libvirt_pool}" | grep "${box_dir_name}" | awk '{print $1}' | xargs -I {} virsh --connect qemu:///system vol-delete --pool "${libvirt_pool}" {}
fi

# Add the local image to the Vagrant cache if necessary.
if [ ! -n "${VAGRANT_SERVER_URL}" ]
then
    echo 'Environment variable VAGRANT_SERVER_URL not found, therefore using local boxes.'
    if [ "${vagrantfile}" == "Vagrantfile.libvirt" ]
    then
        local_image=`jq -r ".\"${image}\".local_libvirt_image" ../descriptions.json`
    else
        local_image=`jq -r ".\"${image}\".local_virtualbox_image" ../descriptions.json`
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
