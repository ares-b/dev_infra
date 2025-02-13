variable "cloud_provider" {
  description = "The cloud provider to deploy to"
  type        = string

  validation {
    condition     = contains(["oracle_alwaysfree"], var.cloud_provider)
    error_message = "Allowed values: 'oracle_alwaysfree'."
  }

  default = "oracle_alwaysfree"
}

# Users & Groups
variable "managed_groups" {
  description = "List of managed groups with their configurations"
  type = list(object({
    name = string
    sudo = object({
      passwordless = bool
      commands = string
    })
  }))

  default = []
}

variable "managed_users" {
  description = "List of managed users with their configurations"
  type = list(object({
    name = string
    create_home = bool
    groups = list(string)
    ssh_authorized_keys = list(string)
  }))
  default = []
}