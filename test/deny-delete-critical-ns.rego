package kubernetes.admission

import data.kubernetes.namespaces

operations = {"DELETE"}

lockDownNamespaces = {"kube-system", "ns1"}

trustedUsers = {"opa-admin"}

deny[msg] {
	input.request.kind.kind == "Namespace"
        ns := input.request.name
        lockDownNamespaces[ns]

	user := input.request.userInfo.username
        not trustedUsers[user]
	operations[input.request.operation]
	msg := sprintf("delete namespace %q by %q denied", [ns, user])
}
