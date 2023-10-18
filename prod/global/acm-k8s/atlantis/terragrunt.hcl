locals {
  creds = yamldecode(sops_decrypt_file(("creds.yaml")))
}

include "helm" {
  path = find_in_parent_folders("_providers/helm.hcl")
}

include  {
  path = find_in_parent_folders("state.hcl")
}

terraform {
  source = "tfr:///terraform-module/release/helm//?version=2.8.1"
}

inputs = {
  namespace  = "cicd"
  repository = "https://runatlantis.github.io/helm-charts"

  app = {
    name    = "atlantis"
    version = "4.15.2"
    chart   = "atlantis"
    deploy  = 1
  }

  values = [templatefile("values.yaml", {
    token  = local.creds.token
    secret = local.creds.secret 
  })]
}
