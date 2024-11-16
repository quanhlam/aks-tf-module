
output "master-ip" {
  value = module.kubemaster.public_id_address
}

output "node-01-ip" {
  value = module.kubenode01.public_id_address
}

output "node-02-ip" {
  value = module.kubenode02.public_id_address
}
