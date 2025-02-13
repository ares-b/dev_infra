output "ip" {
    value = {
        for net in docker_container.service_container.network_data : net.network_name => net.ip_address
    }
}