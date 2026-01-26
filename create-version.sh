#!/bin/bash
# Creates a version on a Vagrant server.
# Usage:
# ./create-version.sh <org> <box> <version>

set -e

org=$1
box=$2
version=$3

if [ ! -n "${org}" ] || [ ! -n "${box}" ] || [ ! -n "${version}" ]
then
    echo 'Usage: ./create-version.sh <org> <box> <version>'
    exit 1
fi
if ! jq -e "has(\"${org}/${box}\")" descriptions.json > /dev/null
then
    echo "Unknown image ${org}/${box}."
    exit 1
fi

function upload_image() {
    provider=$1
    path=`jq -r ".\"${org}/${box}\".local_${provider}_image" descriptions.json`
    if [ "${path}" == 'null' ]
    then
        echo "Failed to get a path for the ${provider} provider."
        return 1
    fi
    if [ ! -f "${path}" ]
    then
        echo "File ${path} does not exists."
        return 1
    fi
    echo "Uploading ${path} as the ${provider} provider for ${org}/${box} v${version}..."
    vagrant cloud publish "${org}/${box}" "${version}" "${provider}" "${path}"
    return $?
}

vagrant cloud version create "${org}/${box}" "${version}"
upload_image libvirt
upload_image virtualbox || true
vagrant cloud version release "${org}/${box}" "${version}"
./update-version.sh "${org}" "${box}" "${version}"
echo 'Done!'
