#sudo iptables -t filter -F
#sudo iptables -t filter -X
#sudo systemctl restart docker
if docker rm -f nginx >& /dev/null #$(docker ps -aq)
then
    echo "Removed old nginx"
fi

#nodeip=$(oc get nodes -n default -o json | jq '.items[0].status.addresses[0].address' | tr -d '"')
nodeip=192.168.130.11
echo $nodeip
docker run -d \
    --name nginx \
    --restart always \
    --add-host console-openshift-console.apps-crc.testing:${nodeip} \
    --add-host oauth-openshift.apps-crc.testing:${nodeip} \
    --add-host default-route-openshift-image-registry.apps-crc.testing:${nodeip} \
    --add-host downloads-openshift-console.apps-crc.testing:${nodeip} \
    -p 80:80 \
    -p 443:443 \
    --cap-add=ALL \
    docker.zmtrwe.com/nginx:1.19.2 nginx-debug -g "daemon off;" # - built locally and not pushed
sleep 1
container=$(docker ps -aq -f name=nginx)
docker cp ~/scripts/nginx.conf ${container}:/etc/nginx/nginx.conf
docker restart ${container}
   


    #-v /home:/home \
    #-v /etc/pki:/etc/pki \
    #-v /etc/trusted-key.key:/etc/trusted-key.key \

    #-v /etc:/etc \

#[ec2-user@ip-10-2-1-102 ~]$ sudo find /etc/pki/ -name "*.crt"
#/etc/pki/ca-trust/extracted/openssl/ca-bundle.trust.crt
#/etc/pki/ca-trust/source/ca-bundle.legacy.crt
#/etc/pki/tls/certs/ca-bundle.crt
#/etc/pki/tls/certs/ca-bundle.trust.crt
#[ec2-user@ip-10-2-1-102 ~]$ sudo find /etc/pki/ -name "*.key"
#[ec2-user@ip-10-2-1-102 ~]$ sudo find /etc/pki/ -name "*.pem"
#/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
#/etc/pki/ca-trust/extracted/pem/email-ca-bundle.pem
#/etc/pki/ca-trust/extracted/pem/objsign-ca-bundle.pem
#/etc/pki/tls/cert.pem
#[ec2-user@ip-10-2-1-102 ~]$ sudo find / -name "*.key"
#/etc/trusted-key.key
#/etc/unbound/root.key
