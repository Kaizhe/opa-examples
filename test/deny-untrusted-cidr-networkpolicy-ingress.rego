package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE"}

policy = {"NetworkPolicy"}

trustedIngressCIDR = {"172.16.0.0/16"}

deny[msg] {
	objectType := input.request.kind.kind
        objectName := input.request.object.metadata.name
        objectNamespace := input.request.object.metadata.namespace
        policy[objectType]
	operations[input.request.operation]

	ingressCIDR := input.request.object.spec.ingress[_].from[_].ipBlock.cidr
	not trustedIngressCIDR[ingressCIDR] 

	msg := sprintf("create network policy %q (namespace: %q) with untrusted ingress CIDR: %q", [objectName, objectNamespace, ingressCIDR])
}
