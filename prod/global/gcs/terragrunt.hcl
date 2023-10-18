locals {
  # Auto load env vars
  project_id = read_terragrunt_config(find_in_parent_folders("env-vars.hcl")).locals.project_id
  git_repo = read_terragrunt_config(find_in_parent_folders("env-vars.hcl")).locals.git_repo
  branch = read_terragrunt_config(find_in_parent_folders("env-vars.hcl")).locals.branch
}

# Define location for the root module
terraform {
  source = "${local.git_repo}//gcs?ref=${local.branch}"
}

# for the backend state prefix
# generated-prefix-path in the gcs bucket: /env/prod/global/gcs/default.tfstate 
include {
  path = find_in_parent_folders()
}

# Inputs to our root module(terraform.tfvar content) with interpolation if needed.
# Pass the variables values to the root modules
inputs = {
  project_id = local.project_id
  prefix     = "${local.project_id}"
  names      = ["bucket_1909"] #interpolation example
  location   = "us-central1"
}
