provider "google" {
  project = "terraform-learning-371709"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_project_service" "workflows" {
  service = "workflows.googleapis.com"

  disable_on_destroy = true
}

resource "google_project_service" "vpc_access" {
  service = "vpcaccess.googleapis.com"

  disable_on_destroy = true
}
