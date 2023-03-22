# Empty backend declaration that get dynamically pre-populated by root terragrunt.hcl
terraform {
  backend "gcs" {}
}

# Simple provider declaration
provider "google" {}
Give feedback
