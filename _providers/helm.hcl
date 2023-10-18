generate "provider" {
  path = "helm.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
EOF
}
