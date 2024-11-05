#MCK
export ARM_SUBSCRIPTION_ID=b5421ae3-32df-459b-8a71-52a6b1c9f6d0
export ARM_TENANT_ID=b0257c14-cacc-44c6-8927-5b4ce5de0874

#PERSONAL
export ARM_SUBSCRIPTION_ID=f88ef5ec-75d8-4ab8-b083-979d5ce5cfef
export AZURE_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID

#KARPENTER
CLUSTER_NAME=primary
RG=rg1
KARPENTER_UAI=karpenter-uai-primary
KARPENTER_NAMESPACE=kube-system
export AZURE_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=0d94db9e-1874-4512-b402-b0db1347d8ca
export VNET_SUBNET_ID=/subscriptions/b5421ae3-32df-459b-8a71-52a6b1c9f6d0/resourceGroups/MC_rg1_primary_eastus/providers/Microsoft.Network/virtualNetworks/aks-vnet-31741753/subnets/aks-subnet
curl -sO https://raw.githubusercontent.com/Azure/karpenter-provider-azure/main/hack/deploy/configure-values.sh
chmod +x ./configure-values.sh && ./configure-values.sh ${CLUSTER_NAME} ${RG} karpenter-sa ${KARPENTER_UAI}

export KARPENTER_VERSION=0.5.4

#TERRAFORM
terraform plan --var-file=environments/DEV.tfvars
terraform apply --var-file=environments/DEV.tfvars -auto-approve
