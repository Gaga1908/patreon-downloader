#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

TITLE=$1
FILE_PATH=$2

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "transferring ${TITLE} to media centre"

if [[ $OSTYPE = "darwin"* ]]; then
  DESTINATION=$(echo ${DESTINATION_DIRECTORY} | sed -e 's/ /\\ /g')
else
  DESTINATION=${DESTINATION_DIRECTORY}
fi

if [[ $(uname -a | awk '{print $2}') = ${DESTINATION_MACHINE_NAME} ]]; then
  mv "${FILE_PATH}" "${DESTINATION}"
else
  scp "${FILE_PATH}" ${DESTINATION_MACHINE_USERNAME}@${DESTINATION_MACHINE_HOST}:"${DESTINATION}"
fi

echo "$(date +"%Y-%m-%d %H:%M:%S"),$TITLE" >> "$(dirname "${BASH_SOURCE[0]}")/../persistence/downloaded.txt"
echo "processing ${TITLE} completed"
