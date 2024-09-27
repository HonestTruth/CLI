#!/bin/bash
set -ue

SORT="${1:-3}" #Column number for sort order
ORDER="${2:-r}"
echo -e 'IMAGE ID\tSIZE\tCREATED\t\t\t\tNAME'
docker images --format="{{.ID}}\t{{.Size}}\t{{.CreatedAt}}\t{{.Repository}}:{{.Tag}}"|sort -rk "${SORT}"