terraform {
  # Pull the terraform configuration from the local file system. Terragrunt will make a copy of the source folder in the
  # Terragrunt working directory (typically `.terragrunt-cache`).
  # Note: The source can also reference a module registry to eg. implement a different blueprint for each team
  source = "../../src"

include "root" {
  path = find_in_parent_folders()
}

# Reads values from default.yaml
locals {
  vars = yamldecode(file(find_in_parent_folders("default.yaml", "default.yaml")))
}

# Sets default value for all projects in this category
inputs = merge(
  {
    defaults_file = "defaults.yaml",
    data_dir = "./projects"
  },
  local.vars
)

/** Defines remote state for each subdirectory with a .terragrunt.hcl file
 setting a relative path. */
remote_state {
  backend = "gcs"
  config = {
    bucket   = local.vars.bucket_prefix
    prefix   = path_relative_to_include()
    project  = local.vars.root_project
    location = local.vars.region
  }
}
