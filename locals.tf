locals {
  aks_cluster_name        = "snoodle-3"
  resource_group_location = var.location
  resource_group_name     = var.resource_group_name

  # wi_json_files = fileset(path.module, "workload-identities-solution-4/inputs/*.json")
  # wi_json_data  = merge([for f in local.wi_json_files : jsondecode(file("${path.module}/${f}"))]...)
  karpenter_namespace = "karpenter"
  karpenter_sa        = "karpenter-sa"
  karpenter_roles     = toset(["Virtual Machine Contributor", "Network Contributor", "Managed Identity Operator"])
}
