output "ip" {
  value = module.oracle_alwaysfree[0].alwaysfree_instance_ip
}

output "privatekey" {
  value = module.oracle_alwaysfree[0].alwaysfree_instance_privatekey
  sensitive = true
}
