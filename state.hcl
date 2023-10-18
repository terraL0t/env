remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config  = {
    project  = "lateral-balm-399421"
    location = "europe-north1"
    bucket   = "state_18"
    prefix   = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}"
  }
}
