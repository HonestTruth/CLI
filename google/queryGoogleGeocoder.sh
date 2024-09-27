#!/bin/bash
set -ue

LAT="${1:-39.0438}"
LONG="${2:--77.4874}"
curl -sSfL -X GET "https://maps.googleapis.com/maps/api/geocode/json?latlng=${LAT},${LONG}&key=${GOOGLE_API_KEY}"|jq