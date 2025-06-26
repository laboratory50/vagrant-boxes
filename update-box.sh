#!/bin/bash

set -e

org=$1
box=$2

if [ ! -n "${org}" ] || [ ! -n "${box}" ]
then
    echo 'Usage: ./update-box.sh <org> <box>'
    exit 1
fi

description=`jq -r ".[\"${box}\"][\"description\"]" ./descriptions.json`
short_description=`jq -r ".[\"${box}\"][\"short_description\"]" ./descriptions.json`
echo "Updating description for ${org}/${box}: ${description}."
vagrant cloud box update --description "${description}" --short-description "${short_description}" "${org}/${box}"
