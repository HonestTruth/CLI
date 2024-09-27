#!/bin/bash
set -ue

IMAGE_NAME="${1:-ghcr.io/k3d-io/k3d-proxy:5.7.4}"
SHOW_ONLY_ID="${2:-}"
if [ "${SHOW_ONLY_ID}" ]
then
    SHOW_ONLY_ID="-q"
fi

docker ps -a ${SHOW_ONLY_ID} -f ancestor=$(docker images -aq -f "reference=${IMAGE_NAME}")