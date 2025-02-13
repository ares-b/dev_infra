data "docker_network" "existing_networks" {
  for_each = { for net in var.service.networks : net.name => net }

  name = each.value.name
}

resource "docker_image" "service_image" {
  name = var.service.image
  keep_locally = false
}

resource "docker_container" "service_container" {
  name  = var.service.name
  image = docker_image.service_image.image_id

  env = [for e in var.service.environment : "${e.name}=${e.value}"]
  network_mode = var.service.network_mode
  dynamic "ports" {
    for_each = var.service.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
    }
  }

  dynamic "volumes" {
    for_each = var.service.volumes
    content {
      container_path = volumes.value.container_path
      host_path      = volumes.value.host_path
      read_only      = volumes.value.read_only
    }
  }

  dynamic "networks_advanced" {
    for_each = var.service.networks
    content {
      name          = networks_advanced.value.name
      ipv4_address  = networks_advanced.value.ip
    }
  }
  
  command       = var.service.command
  user          = var.service.user
  privileged    = var.service.privileged
  restart       = var.service.restart_policy
}
