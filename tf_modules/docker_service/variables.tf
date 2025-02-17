variable "service" {
  type = object({
    name            = string
    image           = string
    restart_policy  = optional(string, "on-failure")
    user  = optional(string)
    command         = optional(list(string), [])
    ports           = optional(list(object({
        internal = number
        external = number
    })), [])
    environment     = optional(list(object({
        name    = string
        value   = string
    })), [])
    volumes         = optional(list(object({
        container_path = string
        host_path      = string
        read_only      = optional(bool, false)
    })), [])
    privileged      = optional(bool, false)
    network_mode    = optional(string, "bridge")
    networks        = optional(list(object({
      name   = string
      ip     = optional(string)
    })), [])
  })
}