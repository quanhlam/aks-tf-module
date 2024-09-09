locals {
  aks_cluster_name        = "snoodle-3"
  resource_group_location = "East US"
  resource_group_name     = "rg-1"

  wi_json_files = fileset(path.module, "workload-identities-solution-4/inputs/*.json")
  wi_json_data  = merge([for f in local.wi_json_files : jsondecode(file("${path.module}/${f}"))]...)
}
