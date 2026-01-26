#!/bin/bash
# Updates a version on a Vagrant server.

set -e

org=$1
box=$2
version=$3

if [ ! -n "${org}" ] || [ ! -n "${box}" ] || [ ! -n "${version}" ]
then
    echo 'Usage: ./update-version.sh <org> <box> <version>'
    exit 1
fi

description=`jq -r ".\"${org}/${box}\".last_version" descriptions.json`
if [ "${description}" == 'null' ]
then
    echo "Unknown image ${org}/${box}."
    exit 1
fi
echo "Updating description for ${org}/${box} v${version}: ${description}."
vagrant cloud version update --description "${description}" "${org}/${box}" "${version}"
