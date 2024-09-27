#!/bin/bash
set -ue

export GROUP_ID="${1:-541}"
if [[ -z "${GIT_PAT+x}" ]]
then
    echo "Please add a project access token and store to GIT_PAT"
    exit 1
fi
if [[ -z "${GIT_FQDN+x}" ]]
then
    echo "Please add FQDN and store to GIT_FQDN"
    exit 2
fi

IDS='.[].id'
QUERY_PARAMS='?per_page=1000&order_by=name&sort=asc' #For now hardcode the 1000
AUTH='PRIVATE_TOKEN: '"${GIT_PAT}"
SUBGROUPS_URL='https://'"${GIT_FQDN}"'/api/v4/groups/'"${GROUP_ID}"'/subgroups'"${QUERY_PARAMS}"
NAME_URL="For getting name of subgroup. Could be cleaned up to remove call. Difficult with for iteration on only id."
PROJECTS_URL="For getting projects from subgroup"
ID_NAME='.[]|{"id": .id, "name": .name}' #Helpful to debug

## Human friendly output to easily visualize (in stdout) between subgroups
# @param _ID Identifier of a project
# @param _NAME Project name.
function printName() { 
    _ID="${1-}"
    _NAME="${2-}"
    echo "------------------------------------"
    echo -e "~*~\t${_ID}: ${_NAME}\t\t~*~"
    echo "------------------------------------"
}

## Given a gitlab subgroup. implement with jq to show branch settings of project(s) (in that subgroup)
# @param _ID The id of a subgroup
function printProjectBranchSettings() {
    _ID="${1-}"
    PROJECTS_URL='https://'"${GIT_FQDN}"'/api/v4/groups'"${_ID}"'/projects'"${QUERY_PARAMS}"
    PROJECTS=$(curl -sSfL --header "${AUTH}" "${PROJECTS_URL}"|jq -r "${IDS}")
    for p in $(echo "$PROJECTS");
    do
        PROJECT_URL='https://'"${GIT_FQDN}"'/api/v4/projects'"${p}"
        #Protected branches is a separate API call, slurp them together with jq
        {
          curl -sSfL --header "${AUTH}" "${PROJECT_URL}"|jq '{"name": .name, "default": .default_branch}'
          curl -sSfL --header "${AUTH}" "${PROJECT_URL}/protected_branches"|jq '.[].name'|jq -s '{"protected": .}'
        } | jq -s '.[0] * .[1]' && :
    done
    echo ""
}

# MAIN
NAME=$(curl -sSfL --header "${AUTH}" 'https://'"${GIT_FQDN}"'/api/v4/groups'"${GROUP_ID}${QUERY_PARAMS}"|jq -r '.name')
printName "${GROUP_ID}" "${NAME}"
printProjectBranchSettings ${GROUP_ID}
SUBGROUPS=$(curl -sSfL --header "${AUTH}" "${SUBGROUPS_URL}"|jq -r "${IDS}")
for sg in $(echo "$SUBGROUPS");
do
    NAME=$(curl -sSfL --header "${AUTH}" 'https://'"${GIT_FQDN}"'/api/v4/groups'"${sg}${QUERY_PARAMS}"|jq -r '.name')
    printName "${sg}" "${NAME}"
    printProjectBranchSettings "${sg}"
done
# END MAIN