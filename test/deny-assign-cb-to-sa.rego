package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE"}

deny[msg] {
	input.request.kind.kind == "ClusterRoleBinding"
	cbName := input.request.object.metadata.name

	operations[input.request.operation]

        subjectKind := input.request.object.subjects[_].kind
        subjectKind == "ServiceAccount"

	roleName := input.request.object.roleRef.name	

	name := input.request.object.subjects[_].name
	namespace := input.request.object.subjects[_].namespace

	msg := sprintf("clusterrolebinding %q is created to assign clusterrole %q to service account %q in namespace %q", [cbName, roleName, name, namespace])
}

