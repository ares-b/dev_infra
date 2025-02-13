locals {
    oci_accounts  = jsondecode(
        get_env("ORACLE_ACCOUNTS")
    )
    tf_backend    = jsondecode(
        get_env("TF_BACKEND")
    )
    client_side_encryption_passphrase = get_env("CLIENT_SIDE_ENCRYPTION_PASSPHRASE")
}

generate "provider" {
    path        = "provider.tf"
    if_exists   = "overwrite_terragrunt"
    contents    = templatefile("../terragrunt_templates/oci_provider.tpl", {
        tenancy_ocid    = local.oci_accounts["${basename(get_terragrunt_dir())}"].tenancy_ocid
        user_ocid       = local.oci_accounts["${basename(get_terragrunt_dir())}"].user_ocid
        fingerprint     = local.oci_accounts["${basename(get_terragrunt_dir())}"].fingerprint
        private_key     = local.oci_accounts["${basename(get_terragrunt_dir())}"].private_key
        region          = local.oci_accounts["${basename(get_terragrunt_dir())}"].region
    })
}

generate "backend" {
    path        = "backend.tf"
    if_exists   = "overwrite_terragrunt"
    contents    = templatefile("../terragrunt_templates/s3_backend.tpl", {
        bucket      = local.tf_backend.bucket
        region      = local.tf_backend.region
        key         = "profit_prophet/docker_servers/${basename(get_terragrunt_dir())}/terraform.tfstate"
        access_key  = local.tf_backend.access_key
        secret_key  = local.tf_backend.secret_key
        client_side_encryption_passphrase = local.client_side_encryption_passphrase
    })
}

inputs = merge(
    yamldecode(
        file("${get_terragrunt_dir()}/config.yaml"),
    ),
    {
        compartment = {
            parent_compartment_id = local.oci_accounts["${basename(get_terragrunt_dir())}"].tenancy_ocid
        }
    }
)
