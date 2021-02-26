package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE"}

policy = {"NetworkPolicy"}

trustedEgressCIDR = {"10.1.0.0/24"}

deny[msg] {
	objectType := input.request.kind.kind
        objectName := input.request.object.metadata.name
        objectNamespace := input.request.object.metadata.namespace
        policy[objectType]
	operations[input.request.operation]

	egressCIDR := input.request.object.spec.egress[_].to[_].ipBlock.cidr
	not trustedEgressCIDR[egressCIDR] 

	msg := sprintf("create network policy %q (namespace: %q) with untrusted egress CIDR: %q", [objectName, objectNamespace, egressCIDR])
}
