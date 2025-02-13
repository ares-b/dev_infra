output "networks" {
  description = "Details of the created Docker networks"
  value       = keys(docker_network.networks)
}