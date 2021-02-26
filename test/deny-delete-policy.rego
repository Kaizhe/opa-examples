package kubernetes.admission

import data.kubernetes.namespaces

operations = {"DELETE"}

trustedUsers = {"opa-admin"}

policy = {"NetworkPolicy", "PodSecurityPolicy"}

deny[msg] {
	objectType := input.request.kind.kind
        object := input.request.name
        policy[objectType]

	user := input.request.userInfo.username
        not trustedUsers[user]
	operations[input.request.operation]
	msg := sprintf("delete policy %q (%v) by %q denied", [object, objectType, user])
}
