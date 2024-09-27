#!/bin/bash
set -ue

export IMAGE_NAME="${1:-docker}"
export REPOSITORY="${2:-docker}"
curl -sSfL -H "X-JFrog-Art-Api:${ARTIFACTORY_API_KEY}" "https://${ARTIFACTORY_URL}/artifactory/api/docker/${REPOSITORY}/v2/tags/list"|jq