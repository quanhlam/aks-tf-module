#MCK
export ARM_SUBSCRIPTION_ID=b5421ae3-32df-459b-8a71-52a6b1c9f6d0
export ARM_TENANT_ID=b0257c14-cacc-44c6-8927-5b4ce5de0874

#PERSONAL
export ARM_SUBSCRIPTION_ID=f88ef5ec-75d8-4ab8-b083-979d5ce5cfef
export AZURE_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=0d94db9e-1874-4512-b402-b0db1347d8ca
export VNET_SUBNET_ID=/subscriptions/f88ef5ec-75d8-4ab8-b083-979d5ce5cfef/resourceGroups/MC_vm-1_group_snoodle-3_southeastasia/providers/Microsoft.Network/virtualNetworks/aks-vnet-37495715/subnets/aks-subnet
curl -sO https://raw.githubusercontent.com/Azure/karpenter-provider-azure/main/hack/deploy/configure-values.sh
chmod +x ./configure-values.sh && ./configure-values.sh ${CLUSTER_NAME} ${RG} karpenter-sa ${KARPENTER_UAI}
