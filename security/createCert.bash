#!/bin/bash
set -ue

CERT_NAME="${1:-anonymous}"
OUTPUT="${2:-/etc/ssl/certs}"
UPDATE="${3:-}"
if [ $(whoami) != "root" ]
then
    echo "Please run this script as root or sudo"
    exit 1
fi
cd "$(dirname "$0")"
openssl req -newkey rsa:4096 -keyout "${OUTPUT}/${CERT_NAME}.key" -out ${CERT_NAME}.csr -nodes -config ./cert.conf
openssl x509 -req -days 3650 -in ${CERT_NAME}.csr -signkey "${OUTPUT}/${CERT_NAME}.key" -out "${OUTPUT}/${CERT_NAME}.crt"
rm ${CERT_NAME}.csr

if [ "${UPDATE}" ]
then
    #TODO - per OS implementation. rhel goes to /etc/pki/ca-trust/source/anchors?
    cp "${OUTPUT}/${CERT_NAME}.crt" "/usr/local/share/ca-certificates/${CERT_NAME}.crt"
    update-ca-certificates
fi
echo "Successfully created ${CERT_NAME}.crt & ${CERT_NAME}.key @ ${OUTPUT}"