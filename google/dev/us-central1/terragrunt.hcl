terraform {
  # Pull the terraform configuration from the local file system. Terragrunt will make a copy of the source folder in the
  # Terragrunt working directory (typically `.terragrunt-cache`).
  # Note: The source can also reference a module registry to eg. implement a different blueprint for each team
  source = "../../..//src"

/*  # Files to include from the Terraform src directory
  include_in_copy = [
    "main.tf",
    "variables.tf",
    "outputs.tf",
    "provider.tf"
  ]
}*/

# Accepts "path_relative_to_include()" from root, and sets GCS bucket path to
# .state file
include "root" {
  path = find_in_parent_folders()
}

# Sets default value for all projects in this category
inputs = {
    defaults_file = "defaults.yaml"
    data_dir = "./projects"
}
