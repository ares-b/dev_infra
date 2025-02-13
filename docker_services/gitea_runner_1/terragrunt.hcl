include "root" {
  path = find_in_parent_folders()
}

include "common" {
  path = "${get_terragrunt_dir()}/../common.hcl"
}

dependency "gitea" {
    config_path = "${get_terragrunt_dir()}/../../docker_services/gitea"
}