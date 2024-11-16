resource "azurerm_kubernetes_cluster" "cluster" {
  name     = local.aks_cluster_name
  location = local.resource_group_location

  resource_group_name = local.resource_group_name
  dns_prefix          = "${local.aks_cluster_name}dns"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.vm_size
    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment  = "Dev"
    "product_id" = "15336"
  }
}


resource "azurerm_user_assigned_identity" "karpenter-uai" {
  count               = var.enable_karpenter == true ? 1 : 0
  location            = local.resource_group_location
  name                = "karpenter-uai-${local.aks_cluster_name}"
  resource_group_name = local.resource_group_name
  tags = {
    "product_id" = "15336"
  }
}

resource "azurerm_federated_identity_credential" "karpenter-uai-fid" {
  count               = var.enable_karpenter == true ? 1 : 0
  name                = "fid-${local.aks_cluster_name}"
  resource_group_name = local.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.cluster.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.karpenter-uai[0].id
  subject             = "system:serviceaccount:${local.karpenter_namespace}:${local.karpenter_sa}"
}

