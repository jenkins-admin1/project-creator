provider "google" {
  project = "terraform-learning-371709"
  region  = "us-central1"
}

resource "google_project" "new_project" {
  name            = "New Project"
  project_id      = "new-project-id"
  billing_account = "010BAA-5F9EE7-B2E020"
}

resource "google_project_service" "all_apis" {
  project = google_project.new_project.project_id

  service {
    name = "compute.googleapis.com"
  }

  service {
    name = "iam.googleapis.com"
  }

  service {
    name = "cloudresourcemanager.googleapis.com"
  }

  service {
    name = "cloudbilling.googleapis.com"
  }
}
