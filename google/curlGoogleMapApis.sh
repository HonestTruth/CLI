#!/bin/bash
set -ue

LAT="${1:-39.0438}"
LONG="${2:--77.4874}"
curl -sSfL -X GET "https://roads.googleapis.com/v1/nearestRoads?points=${LAT}%2C${LONG}&key=${GOOGLE_API_KEY}"|jq