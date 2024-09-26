#!/usr/bin/env bash
echo health:
curl http://192.168.130.11:1936/healthz/ready
echo
echo routes:
oc get route -A
echo ingres:
oc get ingresscontroller -A -o wide
#oc edit IngressController -n openshift-ingress-operator
#spec:
#  replicas: 1
#  httpHeaders:
#    forwardedHeaderPolicy: Append
#    X-Forwarded-For: if-none
#
