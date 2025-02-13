resource "docker_network" "networks" {
  for_each = { for net in var.networks : net.name => net }

  name   = each.value.name
  driver = each.value.driver

  ipam_config {
    subnet = each.value.subnet
  }
}