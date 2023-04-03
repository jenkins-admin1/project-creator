# Reads values from root.yaml
locals {
  vars = yamldecode(file(find_in_parent_folders("root.yaml", "root.yaml")))
}

# Set inputs from definitions in root.yaml 
inputs = local.vars

/** Defines remote state for each subdirectory with a .terragrunt.hcl file
 setting a relative path. */
remote_state {
  backend = "gcs"
  config = {
    bucket   = local.vars.gcs_bucket
    prefix   = path_relative_to_include()
    project  = local.vars.root_project
    location = local.vars.region
  }
}