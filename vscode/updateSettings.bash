#!/bin/bash
set -ue

mkdir -p ~/.config/Code/User/OLD
mv ~/.config/Code/User/*.json ~/.config/Code/User/OLD/
cp "$(dirname "$0")"/*.json ~/.config/Code/User/