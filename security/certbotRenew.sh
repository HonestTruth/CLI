#!/bin/sh

set -ue
ACTIVE_CERT="${1:-/etc/letsencrypt/live/kaelber.cloud/cert.pem}"
expr=$(openssl x509 -enddate -in $ACTIVE_CERT -noout|sed 's/notAfter=//g')
month=$(echo $expr|awk '{print $1}')
day=$(echo $expr|awk '{print $2}')
year=$(echo $expr|awk '{print $4}')
time=$(echo $expr|awk '{print $3}')
expr=$(date -d "$month $day $year $time" "+%Y-%m-%dT%H:%M:%S")

#echo $expr
#echo $(date --iso-8601=seconds)
if [[ $expr < $(date -d "+1 days" --iso-8601=seconds) ]];
then
  certbot renew 
  service dovecot start
  service postfix start
  docker restart pgadmin
else
  echo "DEBUG. I am $(whoami). Cert is still active, expiration set for: $(expr)"
fi
