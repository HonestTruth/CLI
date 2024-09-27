#!/bin/bash
set -ue 

KEY_NAME="${1:-anonymous}"
OUTPUT="${2:-$HOME/.ssh}"
ssh-keygen -t ecdsa -b 521 -N "" -f "${OUTPUT}/${KEY_NAME}"