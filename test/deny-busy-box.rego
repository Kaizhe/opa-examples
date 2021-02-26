package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE", "UPDATE", "DELETE"}

allowObjects = {"ConfigMap"}

lockDownNamespaces = {"ns1"}

deny[msg] {
        #1 == 1
	input.request.kind.kind == "Namespace"
        #not allowObjects[input.request.kind.kind]
        lockDownNamespaces[input.request.object.metadata.name]
	#operations[input.request.operation]
	#image := input.request.object.spec.containers[_].image
	#image == "busybox"
	#msg := sprintf("image not allowed %q under operation %q", [image, input.request.operation])
	msg := sprintf("request: %v", [input.request])
}

