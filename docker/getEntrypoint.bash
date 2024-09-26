#!/bin/bash
set -ue

IMAGE="${1:-${DOCKER_REGISTRY}/${DOCKER_REPO}/nginx:latest}"
docker image inspect "${IMAGE}"|jq '.[].Config|{"entrypoint": .Entrypoint, "cmd": .Cmd}'