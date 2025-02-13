variable "networks" {
  type = list(object({
    name   = string
    subnet = string
    driver = optional(string, "bridge")
  }))
}