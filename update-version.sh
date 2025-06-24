#!/bin/bash

set -e

org=$1
box=$2
version=$3

if [ ! -n "${org}" ] || [ ! -n "${box}" ] || [ ! -n "${version}" ]
then
    echo 'Usage: ./update-version.sh <org> <box> <version>'
    exit 1
fi

description=`jq -r ".${box}.last_version" ./descriptions.json`
echo "Updating description for ${org}/${box} v${ver}: ${description}."
vagrant cloud version update --description "${description}" "${org}/${box}" "${ver}"
