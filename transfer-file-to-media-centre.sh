#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

TITLE=$1
FILE_PATH=$2

echo "transferring ${TITLE} to media centre"

if [[ $OSTYPE = "darwin"* ]]; then
  DESTINATION=${DESTINATION_DIRECTORY_FROM_MAC}
else
  DESTINATION=${DESTINATION_DIRECTORY}
fi

if [[ $(uname -a | awk '{print $2}') = ${DESTINATION_MACHINE_NAME} ]]; then
  mv "${FILE_PATH}" "${DESTINATION}"
else
  scp "${FILE_PATH}" ${MEDIA_CENTRE_USERNAME}@${MEDIA_CENTRE_HOST}:"${DESTINATION}"
fi

echo "$(date +"%Y-%m-%d %H:%M:%S"),$TITLE" >> persistence/downloaded.txt
echo "processing ${TITLE} completed"
