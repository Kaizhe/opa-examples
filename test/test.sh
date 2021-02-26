#!/bin/bash

set -eux

kubectl delete cm pod validatingwebhook ns policy cb cp || true

#kubectl create configmap pod --from-file=deny-busy-box.rego || true
#kubectl create configmap ns --from-file=deny-delete-critical-ns.rego || true
#kubectl create configmap validatingwebhook --from-file=deny-delete-validatingwebhook.rego || true
#kubectl create configmap policy --from-file=deny-delete-policy.rego || true
#kubectl create configmap policy --from-file=deny-untrusted-cidr-networkpolicy-egress.rego || true
#kubectl create configmap policy --from-file=deny-untrusted-cidr-networkpolicy-ingress.rego || true
kubectl create configmap cp --from-file=deny-copy.rego || true
#kubectl create configmap cb --from-file=deny-assign-cb-to-sa.rego || true

sleep 1

#kubectl delete -f busy-box.yaml || true
#kubectl apply -f busy-box.yaml

#kubectl delete validatingwebhookconfiguration opa-validating-webhook
#kubectl delete ns ns1
