package kubernetes.admission

import data.kubernetes.namespaces

operations = {"DELETE"}

trustedUsers = {"opa-admin"}

deny[msg] {
	input.request.kind.kind == "ValidatingWebhookConfiguration"
	operations[input.request.operation]
	user := input.request.userInfo.username
        not trustedUsers[user]
	msg := sprintf("request %v", [input.request])
}

