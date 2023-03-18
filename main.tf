provider "google" {
  project = "terraform-learning-371709"
  region  = "us-central1"
}

resource "google_project" "new_project" {
  name           = "New Project"
  project_id     = "my-new-project-id-123"
  billing_account = "010BAA-5F9EE7-B2E020"
}

resource "google_project_service" "compute_engine_api" {
  project = google_project.new_project.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "network_api" {
  project = google_project.new_project.project_id
  service = "networkmanagement.googleapis.com"
}
