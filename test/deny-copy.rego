package kubernetes.admission

import data.kubernetes.namespaces

operations = {"CREATE"}

trustedUsers = {"opa-admin"}

deny[reason] {
  input.request.kind.kind == "PodExecOptions"
  input.request.resource.resource == "pods"
  input.request.subResource == "exec"
  input.request.object.command[0] == "tar"
  reason = sprintf("CVE-2019-1002101 was detected on %v/%v by user: %v", [
    input.request.namespace,
    input.request.object.container,
    input.request.userInfo.username])
}
