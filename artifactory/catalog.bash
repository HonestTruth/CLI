#!/bin/bash
set -ue

export REPOSITORY="${1:-docker}"
curl -sSfL -H "X-JFrog-Art-Api:${ARTIFACTORY_API_KEY}" "https://${ARTIFACTORY_URL}/artifactory/api/docker/${REPOSITORY}/v2/_catalog"|jq